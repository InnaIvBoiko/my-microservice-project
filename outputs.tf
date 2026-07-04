# --- S3 backend ---
output "s3_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  value       = module.s3_backend.s3_bucket_name
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table used for state locking"
  value       = module.s3_backend.dynamodb_table_name
}

# --- VPC ---
output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnets
}

# --- ECR ---
output "ecr_repository_url" {
  description = "URL of the ECR repository — paste ACCOUNT_ID part into Jenkinsfile"
  value       = module.ecr.repository_url
}

# --- EKS ---
output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.eks_cluster_name
}

output "oidc_provider_arn" {
  description = "ARN of the EKS OIDC provider"
  value       = module.eks.oidc_provider_arn
}

# --- Jenkins ---
output "jenkins_release" {
  description = "Name of the Jenkins Helm release"
  value       = module.jenkins.jenkins_release_name
}

output "jenkins_namespace" {
  description = "Kubernetes namespace where Jenkins is deployed"
  value       = module.jenkins.jenkins_namespace
}

# --- ArgoCD ---
output "argocd_server" {
  description = "In-cluster DNS address of the ArgoCD server"
  value       = module.argo_cd.argo_cd_server_service
}

output "argocd_admin_password_command" {
  description = "Command to retrieve the initial ArgoCD admin password"
  value       = module.argo_cd.admin_password_command
}

# --- Monitoring ---
output "grafana_port_forward_command" {
  description = "Command to reach the Grafana UI locally (default user: admin)"
  value       = module.monitoring.grafana_port_forward_command
}

output "prometheus_port_forward_command" {
  description = "Command to reach the Prometheus UI locally"
  value       = module.monitoring.prometheus_port_forward_command
}

# --- Ingress / TLS (uncomment when module "ingress" is enabled) ---
# output "jenkins_url" {
#   value = module.ingress.jenkins_url
# }
# output "argocd_url" {
#   value = module.ingress.argocd_url
# }
# output "acm_certificate_arn" {
#   value = module.ingress.acm_certificate_arn
# }
# output "jenkins_alb_hostname" {
#   value = module.ingress.jenkins_alb_hostname
# }
# output "argocd_alb_hostname" {
#   value = module.ingress.argocd_alb_hostname
# }
