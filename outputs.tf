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
  description = "URL of the ECR repository"
  value       = module.ecr.repository_url
}

# --- VPC extras ---
output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

# --- EKS ---
output "eks_cluster_endpoint" {
  description = "EKS API endpoint for connecting to the cluster"
  value       = module.eks.eks_cluster_endpoint
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.eks_cluster_name
}

output "eks_node_role_arn" {
  description = "IAM role ARN for EKS worker nodes"
  value       = module.eks.eks_node_role_arn
}
