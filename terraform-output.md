# Terraform apply — output (lesson-5)

**Command:** `terraform apply`
**Region:** us-west-2 — **Account:** 740948698725

**Result:** `Apply complete! Resources: 30 added, 0 changed, 0 destroyed.`

Below is the full execution plan (the resources Terraform created), the apply log,
and the final outputs.

---

# module.ecr.aws_ecr_lifecycle_policy.this will be created

- resource "aws_ecr_lifecycle_policy" "this" {
  - id = (known after apply)
  - policy = jsonencode({ rules = [{ action = { type = "expire" }, description = "Keep only the last 10 images", rulePriority = 1, selection = { countNumber = 10, countType = "imageCountMoreThan", tagStatus = "any" } }] })
  - registry_id = (known after apply)
  - repository = "lesson-5-ecr"
    }

# module.ecr.aws_ecr_repository.this will be created

- resource "aws_ecr_repository" "this" {
  - arn = (known after apply)
  - force_delete = false
  - id = (known after apply)
  - image_tag_mutability = "MUTABLE"
  - name = "lesson-5-ecr"
  - registry_id = (known after apply)
  - repository_url = (known after apply)
  - tags = { "ManagedBy" = "Terraform", "Name" = "lesson-5-ecr", "Project" = "lesson-5" }

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
  - repository = "lesson-5-ecr"
    }

# module.s3_backend.aws_dynamodb_table.terraform_locks will be created

- resource "aws_dynamodb_table" "terraform_locks" {
  - arn = (known after apply)
  - billing_mode = "PAY_PER_REQUEST"
  - hash_key = "LockID"
  - id = (known after apply)
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

Plan: 30 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────

```
macbookpro@MacBook-Pro-MacBook my-microservice-project % terraform apply -auto-approve

module.ecr.data.aws_caller_identity.current: Reading...
module.ecr.data.aws_caller_identity.current: Read complete after 0s [id=740948698725]
module.ecr.aws_ecr_repository.this: Creating...
module.s3_backend.aws_dynamodb_table.terraform_locks: Creating...
module.s3_backend.aws_s3_bucket.terraform_state: Creating...
module.vpc.aws_vpc.main: Creating...
module.ecr.aws_ecr_repository.this: Creation complete after 1s [id=lesson-5-ecr]
module.ecr.aws_ecr_repository_policy.this: Creating...
module.ecr.aws_ecr_lifecycle_policy.this: Creating...
module.ecr.aws_ecr_lifecycle_policy.this: Creation complete after 0s [id=lesson-5-ecr]
module.ecr.aws_ecr_repository_policy.this: Creation complete after 0s [id=lesson-5-ecr]
module.s3_backend.aws_s3_bucket.terraform_state: Creation complete after 3s [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_ownership_controls.terraform_state_ownership: Creating...
module.s3_backend.aws_s3_bucket_versioning.terraform_state_versioning: Creating...
module.s3_backend.aws_s3_bucket_public_access_block.terraform_state_public_access: Creating...
module.s3_backend.aws_s3_bucket_server_side_encryption_configuration.terraform_state_encryption: Creating...
module.s3_backend.aws_s3_bucket_ownership_controls.terraform_state_ownership: Creation complete after 0s [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_public_access_block.terraform_state_public_access: Creation complete after 0s [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_server_side_encryption_configuration.terraform_state_encryption: Creation complete after 0s [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_versioning.terraform_state_versioning: Creation complete after 2s [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_lifecycle_configuration.terraform_state_lifecycle: Creating...
module.s3_backend.aws_dynamodb_table.terraform_locks: Creation complete after 10s [id=terraform-locks]
module.vpc.aws_vpc.main: Creation complete after 6s [id=vpc-0a6aa1888d78815ac]
module.vpc.aws_internet_gateway.igw: Creating...
module.vpc.aws_route_table.public: Creating...
module.vpc.aws_route_table.private: Creating...
module.vpc.aws_subnet.private[0]: Creating...
module.vpc.aws_subnet.private[1]: Creating...
module.vpc.aws_subnet.private[2]: Creating...
module.vpc.aws_subnet.public[0]: Creating...
module.vpc.aws_subnet.public[1]: Creating...
module.vpc.aws_subnet.public[2]: Creating...
module.vpc.aws_eip.nat: Creating...
module.vpc.aws_internet_gateway.igw: Creation complete after 1s [id=igw-0979a5ad5f2a2ad06]
module.vpc.aws_route_table.public: Creation complete after 1s [id=rtb-009ff42d4b327024]
module.vpc.aws_route_table.private: Creation complete after 1s [id=rtb-08548098640288ddc1]
module.vpc.aws_route.public_internet: Creating...
module.vpc.aws_subnet.private[1]: Creation complete after 1s [id=subnet-0c0cf6218c85940ba]
module.vpc.aws_route.public_internet: Creation complete after 1s [id=r-rtb-009ff42d4b3270c241080289494]
module.vpc.aws_eip.nat: Creation complete after 2s [id=eipalloc-0b5982dcd14b1148a]
module.vpc.aws_subnet.private[0]: Creation complete after 2s [id=subnet-052dd6d5d0ca34e4a]
module.vpc.aws_subnet.private[2]: Creation complete after 5s [id=subnet-0cc9c8b31e3d9729b]
module.vpc.aws_route_table_association.private[0]: Creation complete after 1s [id=rtbassoc-01dba1d314e6963de]
module.vpc.aws_route_table_association.private[1]: Creation complete after 1s [id=rtbassoc-0562b91caec183722]
module.vpc.aws_route_table_association.private[2]: Creation complete after 1s [id=rtbassoc-05862c5bf10b8941a]
module.vpc.aws_subnet.public[0]: Creation complete after 16s [id=subnet-08df0b204366c91ac]
module.vpc.aws_subnet.public[1]: Creation complete after 16s [id=subnet-077e24fd3f2bba393]
module.vpc.aws_subnet.public[2]: Creation complete after 13s [id=subnet-0971f9c832c85f6c8]
module.vpc.aws_route_table_association.public[0]: Creation complete after 1s [id=rtbassoc-087ef6c2ae8096cf6]
module.vpc.aws_route_table_association.public[1]: Creation complete after 1s [id=rtbassoc-01cf64e27c2bcd1a6]
module.vpc.aws_route_table_association.public[2]: Creation complete after 2s [id=rtbassoc-0e1d7c90710c42090]
module.s3_backend.aws_s3_bucket_lifecycle_configuration.terraform_state_lifecycle: Creation complete after 59s [id=terraform-state-inna-boiko-2026]
module.vpc.aws_nat_gateway.nat: Creation complete after 1m48s [id=nat-06326ee6ccbfd6826]
module.vpc.aws_route.private_nat: Creation complete after 1s [id=r-rtb-08548098640288ddc11080289494]

Apply complete! Resources: 30 added, 0 changed, 0 destroyed.

Outputs:

dynamodb_table_name = "terraform-locks"
ecr_repository_url = "740948698725.dkr.ecr.us-west-2.amazonaws.com/lesson-5-ecr"
private_subnet_ids = [
  "subnet-052dd6d5d0ca34e4a",
  "subnet-0c0cf6218c85940ba",
  "subnet-0cc9c8b31e3d9729b",
]
public_subnet_ids = [
  "subnet-08df0b204366c91ac",
  "subnet-077e24fd3f2bba393",
  "subnet-0971f9c832c85f6c8",
]
s3_bucket_name = "terraform-state-inna-boiko-2026"
vpc_id = "vpc-0a6aa1888d78815ac"
```
