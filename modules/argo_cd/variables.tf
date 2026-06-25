variable "name" {
  description = "Name of the ArgoCD Helm release"
  type        = string
  default     = "argo-cd"
}

variable "namespace" {
  description = "Kubernetes namespace for ArgoCD"
  type        = string
  default     = "argocd"
}

variable "chart_version" {
  description = "ArgoCD Helm chart version"
  type        = string
  default     = "7.4.4"
}

variable "repo_url" {
  description = "Git repository URL that ArgoCD will track"
  type        = string
}

variable "target_revision" {
  description = "Git branch or tag ArgoCD will sync from"
  type        = string
  default     = "main"
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
