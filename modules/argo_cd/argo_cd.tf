resource "helm_release" "argo_cd" {
  name       = var.name
  namespace  = var.namespace
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.chart_version

  values = [file("${path.module}/values.yaml")]

  create_namespace = true
}

# Repository credentials stored as a Kubernetes Secret with the ArgoCD label.
# ArgoCD discovers secrets with this label automatically — no credentials in chart values.
resource "kubernetes_secret_v1" "argocd_repo" {
  metadata {
    name      = "argocd-repo-django"
    namespace = var.namespace
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  data = {
    type     = "git"
    url      = var.repo_url
    username = var.github_username
    password = var.github_token
  }

  type = "Opaque"

  depends_on = [helm_release.argo_cd]
}

# Local Helm chart that creates ArgoCD Application CRDs
resource "helm_release" "argo_apps" {
  name             = "${var.name}-apps"
  chart            = "${path.module}/charts"
  namespace        = var.namespace
  create_namespace = false

  set = [
    {
      name  = "global.repoURL"
      value = var.repo_url
    },
    {
      name  = "global.targetRevision"
      value = var.target_revision
    },
  ]

  depends_on = [
    helm_release.argo_cd,
    kubernetes_secret_v1.argocd_repo,
  ]
}
