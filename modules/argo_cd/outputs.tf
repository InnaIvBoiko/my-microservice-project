output "argo_cd_server_service" {
  description = "In-cluster DNS address of the ArgoCD server"
  value       = "${var.name}-argocd-server.${var.namespace}.svc.cluster.local"
}

output "admin_password_command" {
  description = "Command to retrieve the initial ArgoCD admin password"
  value       = "kubectl -n ${var.namespace} get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
}
