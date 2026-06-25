variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "jenkins_admin_username" {
  description = "Jenkins admin username"
  type        = string
  sensitive   = true
}

variable "jenkins_admin_password" {
  description = "Jenkins admin password (min 12 chars recommended)"
  type        = string
  sensitive   = true
}

variable "github_username" {
  description = "GitHub username for repository access"
  type        = string
}

variable "github_token" {
  description = "GitHub Personal Access Token with repo scope"
  type        = string
  sensitive   = true
}

variable "oidc_provider_arn" {
  description = "ARN of the EKS OIDC provider (used for IRSA)"
  type        = string
}

variable "oidc_provider_url" {
  description = "Issuer URL of the EKS OIDC provider (with https://)"
  type        = string
}

variable "ecr_registry" {
  description = "AWS ECR registry URL (account_id.dkr.ecr.region.amazonaws.com)"
  type        = string
}
