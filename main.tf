terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Project-level variables
variable "aws_region" {
  description = "AWS region used to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "project_name" {
  description = "Project name (used in tags and resource names)"
  type        = string
  default     = "lesson-5"
}

# Common tags applied to all resources
locals {
  common_tags = {
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}

# S3 and DynamoDB module
module "s3_backend" {
  source      = "./modules/s3-backend"            # Path to the module
  bucket_name = "terraform-state-inna-boiko-2026" # S3 bucket name (must be globally unique)
  table_name  = "terraform-locks"                 # DynamoDB table name
}

# VPC module
module "vpc" {
  source             = "./modules/vpc"                               # Path to the VPC module
  vpc_cidr_block     = "10.0.0.0/16"                                 # CIDR block for the VPC
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] # Public subnets
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"] # Private subnets
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]    # Availability zones
  vpc_name           = "vpc"                                         # VPC name
}

# ECR module for storing Docker images
module "ecr" {
  source = "./modules/ecr"

  ecr_name     = "${var.project_name}-ecr"
  scan_on_push = true
  tags         = local.common_tags
}

# EKS module — managed Kubernetes cluster with a node group
module "eks" {
  source        = "./modules/eks"
  cluster_name  = "eks-cluster-demo"
  subnet_ids    = module.vpc.public_subnets
  instance_type = "t3.medium"
  desired_size  = 1
  max_size      = 2
  min_size      = 1
}

