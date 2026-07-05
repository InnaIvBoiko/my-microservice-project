variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "region" {
  description = "AWS region (used for ALB zone ID lookup)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the EKS cluster runs"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs — tagged so the ALB controller can discover them for internet-facing ALBs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private subnet IDs — tagged with the cluster name for the ALB controller"
  type        = list(string)
}

variable "oidc_provider_arn" {
  description = "ARN of the EKS OIDC provider (for IRSA)"
  type        = string
}

variable "oidc_provider_url" {
  description = "Issuer URL of the EKS OIDC provider (with https://)"
  type        = string
}

variable "domain_name" {
  description = "Root domain managed in Route53 (e.g. example.com). A wildcard ACM cert will be issued for it."
  type        = string
}

variable "jenkins_subdomain" {
  description = "Subdomain for Jenkins (results in jenkins.<domain_name>)"
  type        = string
  default     = "jenkins"
}

variable "argocd_subdomain" {
  description = "Subdomain for ArgoCD (results in argocd.<domain_name>)"
  type        = string
  default     = "argocd"
}

variable "jenkins_namespace" {
  description = "Kubernetes namespace where Jenkins is deployed"
  type        = string
  default     = "jenkins"
}

variable "argocd_namespace" {
  description = "Kubernetes namespace where ArgoCD is deployed"
  type        = string
  default     = "argocd"
}
