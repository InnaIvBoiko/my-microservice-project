variable "namespace" {
  description = "Kubernetes namespace for Prometheus and Grafana"
  type        = string
  default     = "monitoring"
}

variable "chart_version" {
  description = "Version of the kube-prometheus-stack Helm chart — verify with `helm search repo kube-prometheus-stack --versions` before applying"
  type        = string
  default     = "65.5.1"
}

variable "grafana_admin_password" {
  description = "Grafana admin password (min 12 chars recommended)"
  type        = string
  sensitive   = true
}

variable "storage_class" {
  description = "StorageClass used for Prometheus/Grafana/Alertmanager persistent volumes"
  type        = string
  default     = "ebs-sc"
}
