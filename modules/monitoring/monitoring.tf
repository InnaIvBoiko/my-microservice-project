resource "kubernetes_namespace_v1" "monitoring" {
  metadata {
    name = var.namespace
    labels = {
      "app.kubernetes.io/managed-by" = "Terraform"
    }
  }
}

# Grafana admin credentials — referenced by Helm via admin.existingSecret, never stored as plain text in values.
resource "kubernetes_secret_v1" "grafana_admin" {
  metadata {
    name      = "grafana-admin-secret"
    namespace = kubernetes_namespace_v1.monitoring.metadata[0].name
  }

  data = {
    admin-user     = "admin"
    admin-password = var.grafana_admin_password
  }

  type = "Opaque"
}

resource "helm_release" "kube_prometheus_stack" {
  name             = "kube-prometheus-stack"
  namespace        = kubernetes_namespace_v1.monitoring.metadata[0].name
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = var.chart_version
  create_namespace = false

  values = [
    templatefile("${path.module}/values.yaml", {
      storage_class = var.storage_class
    })
  ]

  depends_on = [
    kubernetes_namespace_v1.monitoring,
    kubernetes_secret_v1.grafana_admin,
  ]
}

# Used by the port-forward output — reads the Grafana Service name after deployment
data "kubernetes_service_v1" "grafana" {
  metadata {
    name      = "kube-prometheus-stack-grafana"
    namespace = helm_release.kube_prometheus_stack.namespace
  }

  depends_on = [helm_release.kube_prometheus_stack]
}
