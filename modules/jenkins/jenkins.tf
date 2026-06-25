# Create the namespace explicitly so secrets can be placed there before Jenkins starts
resource "kubernetes_namespace_v1" "jenkins" {
  metadata {
    name = "jenkins"
    labels = {
      "app.kubernetes.io/managed-by" = "Terraform"
    }
  }
}

# StorageClass backed by EBS gp3 — cluster-wide, set as default
resource "kubernetes_storage_class_v1" "ebs_sc" {
  metadata {
    name = "ebs-sc"
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "true"
    }
  }

  storage_provisioner    = "ebs.csi.aws.com"
  reclaim_policy         = "Delete"
  volume_binding_mode    = "WaitForFirstConsumer"
  allow_volume_expansion = true

  parameters = {
    type      = "gp3"
    encrypted = "true"
  }
}

# Kubernetes Secret holding Jenkins admin credentials.
# Referenced by Helm via controller.admin.existingSecret — never stored as plain text in values.
resource "kubernetes_secret_v1" "jenkins_admin" {
  metadata {
    name      = "jenkins-admin-secret"
    namespace = kubernetes_namespace_v1.jenkins.metadata[0].name
  }

  data = {
    jenkins-admin-user     = var.jenkins_admin_username
    jenkins-admin-password = var.jenkins_admin_password
  }

  type = "Opaque"
}

# Kubernetes Secret holding GitHub credentials.
# Injected into the Jenkins controller pod as environment variables
# so JCasC can reference ${GITHUB_USERNAME} / ${GITHUB_PAT} at startup.
resource "kubernetes_secret_v1" "jenkins_github" {
  metadata {
    name      = "jenkins-github-secret"
    namespace = kubernetes_namespace_v1.jenkins.metadata[0].name
  }

  data = {
    username = var.github_username
    token    = var.github_token
  }

  type = "Opaque"
}

# IAM role assumed by the jenkins-sa service account via IRSA.
# Grants Kaniko pods the ability to push images to ECR without static credentials.
resource "aws_iam_role" "jenkins_kaniko_role" {
  name = "${var.cluster_name}-jenkins-kaniko-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = var.oidc_provider_arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${replace(var.oidc_provider_url, "https://", "")}:sub" = "system:serviceaccount:jenkins:jenkins-sa"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy" "jenkins_ecr_policy" {
  name = "${var.cluster_name}-jenkins-kaniko-ecr-policy"
  role = aws_iam_role.jenkins_kaniko_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload",
        "ecr:DescribeRepositories",
        "ecr:BatchGetImage",
        "ecr:GetDownloadUrlForLayer",
      ]
      Resource = "*"
    }]
  })
}

# Service account used by Jenkins agent pods running Kaniko builds.
# The IRSA annotation links it to the IAM role above.
resource "kubernetes_service_account_v1" "jenkins_sa" {
  metadata {
    name      = "jenkins-sa"
    namespace = kubernetes_namespace_v1.jenkins.metadata[0].name
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.jenkins_kaniko_role.arn
    }
  }

  depends_on = [aws_iam_role_policy.jenkins_ecr_policy]
}

resource "helm_release" "jenkins" {
  name             = "jenkins"
  namespace        = kubernetes_namespace_v1.jenkins.metadata[0].name
  repository       = "https://charts.jenkins.io"
  chart            = "jenkins"
  version          = "5.9.29"
  create_namespace = false

  values = [file("${path.module}/values.yaml")]

  depends_on = [
    kubernetes_namespace_v1.jenkins,
    kubernetes_secret_v1.jenkins_admin,
    kubernetes_secret_v1.jenkins_github,
    kubernetes_service_account_v1.jenkins_sa,
    kubernetes_storage_class_v1.ebs_sc,
  ]
}

# Used by the jenkins_url output to read the LoadBalancer hostname after deployment
data "kubernetes_service_v1" "jenkins" {
  metadata {
    name      = "jenkins"
    namespace = helm_release.jenkins.namespace
  }

  depends_on = [helm_release.jenkins]
}
