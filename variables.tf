variable "aws_region" {
  description = "AWS region used to deploy all resources"
  type        = string
  default     = "us-west-2"
}

variable "project_name" {
  description = "Project name — used as a prefix in resource names and tags"
  type        = string
  default     = "lesson-8-9"
}

variable "jenkins_admin_username" {
  description = "Jenkins admin username"
  type        = string
  sensitive   = true
  default     = "admin"
}

variable "jenkins_admin_password" {
  description = "Jenkins admin password (min 12 chars recommended)"
  type        = string
  sensitive   = true
}

variable "github_username" {
  description = "GitHub username used by Jenkins (credentials) and ArgoCD (repo access)"
  type        = string
}

variable "github_token" {
  description = "GitHub Personal Access Token with repo + workflow scopes"
  type        = string
  sensitive   = true
}

variable "bootstrap_mode" {
  description = "Set true during initial bootstrap (before EKS exists) so providers use placeholder values. Set false after cluster is created."
  type        = bool
  default     = true
}

variable "domain_name" {
  description = "Root domain managed in Route53 (e.g. example.com). Used to issue an ACM wildcard cert and create DNS records for Jenkins and ArgoCD. Leave empty when the ingress module is disabled."
  type        = string
  default     = ""
}
