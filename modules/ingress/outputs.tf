output "jenkins_url" {
  description = "HTTPS URL for Jenkins"
  value       = "https://${var.jenkins_subdomain}.${var.domain_name}"
}

output "argocd_url" {
  description = "HTTPS URL for ArgoCD"
  value       = "https://${var.argocd_subdomain}.${var.domain_name}"
}

output "acm_certificate_arn" {
  description = "ARN of the ACM certificate used by both ALBs"
  value       = aws_acm_certificate_validation.ingress.certificate_arn
}

output "jenkins_alb_hostname" {
  description = "DNS hostname of the Jenkins ALB (available after second terraform apply)"
  value       = try(data.kubernetes_ingress_v1.jenkins_alb.status[0].load_balancer[0].ingress[0].hostname, "ALB not yet provisioned — run terraform apply again")
}

output "argocd_alb_hostname" {
  description = "DNS hostname of the ArgoCD ALB (available after second terraform apply)"
  value       = try(data.kubernetes_ingress_v1.argocd_alb.status[0].load_balancer[0].ingress[0].hostname, "ALB not yet provisioned — run terraform apply again")
}
