terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.27"
    }
    http = {
      source  = "hashicorp/http"
      version = ">= 3.4"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# When bootstrap_mode = true (default on a fresh environment), these data sources
# have count = 0 and are never read — so the providers work even without an EKS cluster.
# Set bootstrap_mode = false in terraform.tfvars after the cluster is created.
data "aws_eks_cluster" "eks" {
  count = var.bootstrap_mode ? 0 : 1
  name  = "${var.project_name}-eks"
}

data "aws_eks_cluster_auth" "eks" {
  count = var.bootstrap_mode ? 0 : 1
  name  = "${var.project_name}-eks"
}

provider "helm" {
  kubernetes = {
    host                   = var.bootstrap_mode ? "https://placeholder" : data.aws_eks_cluster.eks[0].endpoint
    cluster_ca_certificate = var.bootstrap_mode ? "" : base64decode(data.aws_eks_cluster.eks[0].certificate_authority[0].data)
    token                  = var.bootstrap_mode ? "" : data.aws_eks_cluster_auth.eks[0].token
  }
}

provider "kubernetes" {
  host                   = var.bootstrap_mode ? "https://placeholder" : data.aws_eks_cluster.eks[0].endpoint
  cluster_ca_certificate = var.bootstrap_mode ? "" : base64decode(data.aws_eks_cluster.eks[0].certificate_authority[0].data)
  token                  = var.bootstrap_mode ? "" : data.aws_eks_cluster_auth.eks[0].token
}

locals {
  common_tags = {
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}

# ---------------------------------------------------------------------------
# Modules
# ---------------------------------------------------------------------------

module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "terraform-state-inna-boiko-2026"
  table_name  = "terraform-locks"
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  vpc_name           = "vpc"
}

module "ecr" {
  source = "./modules/ecr"

  ecr_name     = "${var.project_name}-ecr"
  scan_on_push = true
  tags         = local.common_tags
}

module "eks" {
  source = "./modules/eks"

  cluster_name  = "${var.project_name}-eks"
  subnet_ids    = module.vpc.private_subnets
  instance_type = "t3.small"
  desired_size  = 3
  max_size      = 4
  min_size      = 1
}

module "jenkins" {
  source = "./modules/jenkins"

  cluster_name           = module.eks.eks_cluster_name
  oidc_provider_arn      = module.eks.oidc_provider_arn
  oidc_provider_url      = module.eks.oidc_provider_url
  ecr_registry           = module.ecr.repository_url
  jenkins_admin_username = var.jenkins_admin_username
  jenkins_admin_password = var.jenkins_admin_password
  github_username        = var.github_username
  github_token           = var.github_token

  providers = {
    helm       = helm
    kubernetes = kubernetes
  }
}

module "argo_cd" {
  source = "./modules/argo_cd"

  namespace       = "argocd"
  chart_version   = "7.4.4"
  repo_url        = "https://github.com/InnaIvBoiko/my-microservice-project.git"
  target_revision = "lesson-8-9"
  github_username = var.github_username
  github_token    = var.github_token

  providers = {
    helm       = helm
    kubernetes = kubernetes
  }
}

# Ingress module (ALB + ACM + HTTPS) — requires a Route53 domain.
# Uncomment when you have a domain configured in Route53.
# module "ingress" {
#   source = "./modules/ingress"
#
#   cluster_name       = module.eks.eks_cluster_name
#   region             = var.aws_region
#   vpc_id             = module.vpc.vpc_id
#   public_subnet_ids  = module.vpc.public_subnets
#   private_subnet_ids = module.vpc.private_subnets
#   oidc_provider_arn  = module.eks.oidc_provider_arn
#   oidc_provider_url  = module.eks.oidc_provider_url
#   domain_name        = var.domain_name
#
#   providers = {
#     helm       = helm
#     kubernetes = kubernetes
#   }
# }
