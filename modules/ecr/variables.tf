variable "ecr_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "Whether image tags can be overwritten (MUTABLE or IMMUTABLE)"
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Scan images for vulnerabilities on push"
  type        = bool
  default     = true
}

variable "force_delete" {
  description = "Allow deleting the repository even if it still contains images"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Common tags applied to resources"
  type        = map(string)
  default     = {}
}
