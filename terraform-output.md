# Terraform apply — output (lesson-7)

**Command:** `terraform apply`
**Region:** us-west-2 — **Account:** 740948698725

**Result:** `Apply complete! Resources: 31 added, 0 changed, 0 destroyed.`

Below is the full execution plan (the resources Terraform created), the apply log,
and the final outputs.

---

# module.ecr.aws_ecr_lifecycle_policy.this will be created

- resource "aws_ecr_lifecycle_policy" "this" {
  - id = (known after apply)
  - policy = jsonencode({ rules = [{ action = { type = "expire" }, description = "Keep only the last 10 images", rulePriority = 1, selection = { countNumber = 10, countType = "imageCountMoreThan", tagStatus = "any" } }] })
  - registry_id = (known after apply)
  - repository = "lesson-7-ecr"
    }

# module.ecr.aws_ecr_repository.this will be created

- resource "aws_ecr_repository" "this" {
  - arn = (known after apply)
  - force_delete = false
  - id = (known after apply)
  - image_tag_mutability = "MUTABLE"
  - name = "lesson-7-ecr"
  - registry_id = (known after apply)
  - repository_url = (known after apply)
  - tags = { "ManagedBy" = "Terraform", "Name" = "lesson-7-ecr", "Project" = "lesson-7" }

  - encryption_configuration {
    - encryption_type = "AES256"
    - kms_key = (known after apply)
      }

  - image_scanning_configuration {
    - scan_on_push = true
      }
    }

# module.ecr.aws_ecr_repository_policy.this will be created

- resource "aws_ecr_repository_policy" "this" {
  - id = (known after apply)
  - policy = jsonencode({ Statement = [{ Action = ["ecr:GetDownloadUrlForLayer", "ecr:BatchGetImage", "ecr:BatchCheckLayerAvailability", "ecr:PutImage", "ecr:InitiateLayerUpload", "ecr:UploadLayerPart", "ecr:CompleteLayerUpload"], Effect = "Allow", Principal = { AWS = "arn:aws:iam::740948698725:root" }, Sid = "AllowPushPull" }], Version = "2008-10-17" })
  - registry_id = (known after apply)
  - repository = "lesson-7-ecr"
    }

# module.eks.aws_eks_cluster.eks will be created

- resource "aws_eks_cluster" "eks" {
  - name = "lesson-7-eks"
  - role_arn = (known after apply)
  - access_config { authentication_mode = "API", bootstrap_cluster_creator_admin_permissions = true }
  - vpc_config { endpoint_private_access = true, endpoint_public_access = true }
    }

# module.eks.aws_eks_node_group.general will be created

- resource "aws_eks_node_group" "general" {
  - cluster_name = "lesson-7-eks"
  - instance_types = ["t3.micro"]
  - labels = { "role" = "general" }
  - node_group_name = "general"
  - capacity_type = "ON_DEMAND"
  - scaling_config { desired_size = 2, max_size = 3, min_size = 1 }
  - update_config { max_unavailable = 1 }
    }

# module.eks.aws_iam_role.eks / nodes will be created (x2)

# module.eks.aws_iam_role_policy_attachment (x4)

- AmazonEKSClusterPolicy → eks cluster role
- AmazonEKSWorkerNodePolicy → nodes role
- AmazonEKS_CNI_Policy → nodes role
- AmazonEC2ContainerRegistryReadOnly → nodes role

# module.s3_backend.aws_dynamodb_table.terraform_locks will be created

- resource "aws_dynamodb_table" "terraform_locks" {
  - billing_mode = "PAY_PER_REQUEST"
  - hash_key = "LockID"
  - name = "terraform-locks"
  - tags = { "Environment" = "lesson-5", "Name" = "Terraform Lock Table" }

  - attribute { name = "LockID", type = "S" }
    }

# module.s3_backend.aws_s3_bucket.terraform_state will be created

- resource "aws_s3_bucket" "terraform_state" {
  - bucket = "terraform-state-inna-boiko-2026"
  - force_destroy = false
  - tags = { "Environment" = "lesson-5", "Name" = "Terraform State Bucket" }
    }

# module.s3_backend.aws_s3_bucket_lifecycle_configuration.terraform_state_lifecycle will be created

- resource "aws_s3_bucket_lifecycle_configuration" "terraform_state_lifecycle" {
  - bucket = (known after apply)

  - rule {
    - id = "expire-old-versions"
    - status = "Enabled"
    - filter {}
    - noncurrent_version_expiration { noncurrent_days = 90 }
    - abort_incomplete_multipart_upload { days_after_initiation = 7 }
      }
    }

# module.s3_backend.aws_s3_bucket_ownership_controls.terraform_state_ownership will be created

- resource "aws_s3_bucket_ownership_controls" "terraform_state_ownership" {
  - bucket = (known after apply)
  - rule { object_ownership = "BucketOwnerEnforced" }
    }

# module.s3_backend.aws_s3_bucket_public_access_block.terraform_state_public_access will be created

- resource "aws_s3_bucket_public_access_block" "terraform_state_public_access" {
  - block_public_acls = true
  - block_public_policy = true
  - bucket = (known after apply)
  - ignore_public_acls = true
  - restrict_public_buckets = true
    }

# module.s3_backend.aws_s3_bucket_server_side_encryption_configuration.terraform_state_encryption will be created

- resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_encryption" {
  - bucket = (known after apply)
  - rule {
    - apply_server_side_encryption_by_default { sse_algorithm = "AES256" }
      }
    }

# module.s3_backend.aws_s3_bucket_versioning.terraform_state_versioning will be created

- resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  - bucket = (known after apply)
  - versioning_configuration { status = "Enabled" }
    }

# module.vpc.aws_eip.nat will be created

- resource "aws_eip" "nat" {
  - domain = "vpc"
  - tags = { "Name" = "vpc-nat-eip" }
    }

# module.vpc.aws_internet_gateway.igw will be created

- resource "aws_internet_gateway" "igw" {
  - tags = { "Name" = "vpc-igw" }
    }

# module.vpc.aws_nat_gateway.nat will be created

- resource "aws_nat_gateway" "nat" {
  - connectivity_type = "public"
  - tags = { "Name" = "vpc-nat" }
    }

# module.vpc.aws_route.private_nat will be created

- resource "aws_route" "private_nat" {
  - destination_cidr_block = "0.0.0.0/0"
    }

# module.vpc.aws_route.public_internet will be created

- resource "aws_route" "public_internet" {
  - destination_cidr_block = "0.0.0.0/0"
    }

# module.vpc.aws_route_table.private / public will be created (x2)

# module.vpc.aws_route_table_association.private[0-2] / public[0-2] will be created (x6)

# module.vpc.aws_subnet.private[0-2] will be created

- cidr_block = "10.0.4.0/24" / "10.0.5.0/24" / "10.0.6.0/24"
- availability_zone = us-west-2a / us-west-2b / us-west-2c

# module.vpc.aws_subnet.public[0-2] will be created

- cidr_block = "10.0.1.0/24" / "10.0.2.0/24" / "10.0.3.0/24"
- map_public_ip_on_launch = true

# module.vpc.aws_vpc.main will be created

- resource "aws_vpc" "main" {
  - cidr_block = "10.0.0.0/16"
  - enable_dns_hostnames = true
  - enable_dns_support = true
  - tags = { "Name" = "vpc-vpc" }
    }

Plan: 31 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────

```
Apply complete! Resources: 31 added, 0 changed, 0 destroyed.

Outputs:

dynamodb_table_name = "terraform-locks"
ecr_repository_url = "740948698725.dkr.ecr.us-west-2.amazonaws.com/lesson-7-ecr"
private_subnet_ids = [
  "subnet-009303d7f8aec1ff2",
  "subnet-0cacaf79c6fb7508e",
  "subnet-079bfb2d2ce23e2cf",
]
public_subnet_ids = [
  "subnet-063b7b7eecbc05d10",
  "subnet-0acea98452dd811aa",
  "subnet-06c7c37c258deb085",
]
s3_bucket_name = "terraform-state-inna-boiko-2026"
vpc_id = "vpc-044d50f2997a0741e"
```
