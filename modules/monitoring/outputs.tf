output "monitoring_namespace" {
  description = "Kubernetes namespace where Prometheus/Grafana are deployed"
  value       = kubernetes_namespace_v1.monitoring.metadata[0].name
}

output "grafana_release_name" {
  description = "Name of the kube-prometheus-stack Helm release"
  value       = helm_release.kube_prometheus_stack.name
}

output "grafana_port_forward_command" {
  description = "Command to reach the Grafana UI locally (default user: admin)"
  value       = "kubectl port-forward svc/${data.kubernetes_service_v1.grafana.metadata[0].name} 3000:80 -n ${var.namespace}"
}

output "prometheus_port_forward_command" {
  description = "Command to reach the Prometheus UI locally"
  value       = "kubectl port-forward svc/kube-prometheus-stack-prometheus 9090:9090 -n ${var.namespace}"
}
