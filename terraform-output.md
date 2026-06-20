# Terraform apply — output (lesson-5)

**Command:** `terraform apply`
**Region:** us-west-2 — **Account:** 740948698725

**Result:** `Apply complete! Resources: 27 added, 0 changed, 0 destroyed.`

Below is the full execution plan (the resources Terraform created), the apply log,
and the final outputs.

---

# module.s3_backend.aws_s3_bucket_ownership_controls.terraform_state_ownership will be created

- resource "aws_s3_bucket_ownership_controls" "terraform_state_ownership" {
  - bucket = (known after apply)
  - id = (known after apply)

  - rule { + object_ownership = "BucketOwnerEnforced"
    }
    }

# module.s3_backend.aws_s3_bucket_versioning.terraform_state_versioning will be created

- resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  - bucket = (known after apply)
  - id = (known after apply)

  - versioning_configuration { + mfa_delete = (known after apply) + status = "Enabled"
    }
    }

# module.vpc.aws_eip.nat will be created

- resource "aws_eip" "nat" {
  - allocation_id = (known after apply)
  - arn = (known after apply)
  - association_id = (known after apply)
  - carrier_ip = (known after apply)
  - customer_owned_ip = (known after apply)
  - domain = "vpc"
  - id = (known after apply)
  - instance = (known after apply)
  - ipam_pool_id = (known after apply)
  - network_border_group = (known after apply)
  - network_interface = (known after apply)
  - private_dns = (known after apply)
  - private_ip = (known after apply)
  - ptr_record = (known after apply)
  - public_dns = (known after apply)
  - public_ip = (known after apply)
  - public_ipv4_pool = (known after apply)
  - tags = {
    - "Name" = "vpc-nat-eip"
      }
  - tags_all = {
    - "Name" = "vpc-nat-eip"
      }
  - vpc = (known after apply)
    }

# module.vpc.aws_internet_gateway.igw will be created

- resource "aws_internet_gateway" "igw" {
  - arn = (known after apply)
  - id = (known after apply)
  - owner_id = (known after apply)
  - tags = {
    - "Name" = "vpc-igw"
      }
  - tags_all = {
    - "Name" = "vpc-igw"
      }
  - vpc_id = (known after apply)
    }

# module.vpc.aws_nat_gateway.nat will be created

- resource "aws_nat_gateway" "nat" {
  - allocation_id = (known after apply)
  - association_id = (known after apply)
  - connectivity_type = "public"
  - id = (known after apply)
  - network_interface_id = (known after apply)
  - private_ip = (known after apply)
  - public_ip = (known after apply)
  - secondary_private_ip_address_count = (known after apply)
  - secondary_private_ip_addresses = (known after apply)
  - subnet_id = (known after apply)
  - tags = {
    - "Name" = "vpc-nat"
      }
  - tags_all = { + "Name" = "vpc-nat"
    }
    }

# module.vpc.aws_route.private_nat will be created

- resource "aws_route" "private_nat" {
  - destination_cidr_block = "0.0.0.0/0"
  - id = (known after apply)
  - instance_id = (known after apply)
  - instance_owner_id = (known after apply)
  - nat_gateway_id = (known after apply)
  - network_interface_id = (known after apply)
  - origin = (known after apply)
  - route_table_id = (known after apply)
  - state = (known after apply)
    }

# module.vpc.aws_route.public_internet will be created

- resource "aws_route" "public_internet" {
  - destination_cidr_block = "0.0.0.0/0"
  - gateway_id = (known after apply)
  - id = (known after apply)
  - instance_id = (known after apply)
  - instance_owner_id = (known after apply)
  - network_interface_id = (known after apply)
  - origin = (known after apply)
  - route_table_id = (known after apply)
  - state = (known after apply)
    }

# module.vpc.aws_route_table.private will be created

- resource "aws_route_table" "private" {
  - arn = (known after apply)
  - id = (known after apply)
  - owner_id = (known after apply)
  - propagating_vgws = (known after apply)
  - route = (known after apply)
  - tags = {
    - "Name" = "vpc-private-rt"
      }
  - tags_all = {
    - "Name" = "vpc-private-rt"
      }
  - vpc_id = (known after apply)
    }

# module.vpc.aws_route_table.public will be created

- resource "aws_route_table" "public" {
  - arn = (known after apply)
  - id = (known after apply)
  - owner_id = (known after apply)
  - propagating_vgws = (known after apply)
  - route = (known after apply)
  - tags = {
    - "Name" = "vpc-public-rt"
      }
  - tags_all = {
    - "Name" = "vpc-public-rt"
      }
  - vpc_id = (known after apply)
    }

# module.vpc.aws_route_table_association.private[0] will be created

- resource "aws_route_table_association" "private" {
  - id = (known after apply)
  - route_table_id = (known after apply)
  - subnet_id = (known after apply)
    }

# module.vpc.aws_route_table_association.private[1] will be created

- resource "aws_route_table_association" "private" {
  - id = (known after apply)
  - route_table_id = (known after apply)
  - subnet_id = (known after apply)
    }

# module.vpc.aws_route_table_association.private[2] will be created

- resource "aws_route_table_association" "private" {
  - id = (known after apply)
  - route_table_id = (known after apply)
  - subnet_id = (known after apply)
    }

# module.vpc.aws_route_table_association.public[0] will be created

- resource "aws_route_table_association" "public" {
  - id = (known after apply)
  - route_table_id = (known after apply)
  - subnet_id = (known after apply)
    }

# module.vpc.aws_route_table_association.public[1] will be created

- resource "aws_route_table_association" "public" {
  - id = (known after apply)
  - route_table_id = (known after apply)
  - subnet_id = (known after apply)
    }

# module.vpc.aws_route_table_association.public[2] will be created

- resource "aws_route_table_association" "public" {
  - id = (known after apply)
  - route_table_id = (known after apply)
  - subnet_id = (known after apply)
    }

# module.vpc.aws_subnet.private[0] will be created

- resource "aws_subnet" "private" {
  - arn = (known after apply)
  - assign_ipv6_address_on_creation = false
  - availability_zone = "us-west-2a"
  - availability_zone_id = (known after apply)
  - cidr_block = "10.0.4.0/24"
  - enable_dns64 = false
  - enable_resource_name_dns_a_record_on_launch = false
  - enable_resource_name_dns_aaaa_record_on_launch = false
  - id = (known after apply)
  - ipv6_cidr_block_association_id = (known after apply)
  - ipv6_native = false
  - map_public_ip_on_launch = false
  - owner_id = (known after apply)
  - private_dns_hostname_type_on_launch = (known after apply)
  - tags = {
    - "Name" = "vpc-private-subnet-1"
      }
  - tags_all = {
    - "Name" = "vpc-private-subnet-1"
      }
  - vpc_id = (known after apply)
    }

# module.vpc.aws_subnet.private[1] will be created

- resource "aws_subnet" "private" {
  - arn = (known after apply)
  - assign_ipv6_address_on_creation = false
  - availability_zone = "us-west-2b"
  - availability_zone_id = (known after apply)
  - cidr_block = "10.0.5.0/24"
  - enable_dns64 = false
  - enable_resource_name_dns_a_record_on_launch = false
  - enable_resource_name_dns_aaaa_record_on_launch = false
  - id = (known after apply)
  - ipv6_cidr_block_association_id = (known after apply)
  - ipv6_native = false
  - map_public_ip_on_launch = false
  - owner_id = (known after apply)
  - private_dns_hostname_type_on_launch = (known after apply)
  - tags = {
    - "Name" = "vpc-private-subnet-2"
      }
  - tags_all = {
    - "Name" = "vpc-private-subnet-2"
      }
  - vpc_id = (known after apply)
    }

# module.vpc.aws_subnet.private[2] will be created

- resource "aws_subnet" "private" {
  - arn = (known after apply)
  - assign_ipv6_address_on_creation = false
  - availability_zone = "us-west-2c"
  - availability_zone_id = (known after apply)
  - cidr_block = "10.0.6.0/24"
  - enable_dns64 = false
  - enable_resource_name_dns_a_record_on_launch = false
  - enable_resource_name_dns_aaaa_record_on_launch = false
  - id = (known after apply)
  - ipv6_cidr_block_association_id = (known after apply)
  - ipv6_native = false
  - map_public_ip_on_launch = false
  - owner_id = (known after apply)
  - private_dns_hostname_type_on_launch = (known after apply)
  - tags = {
    - "Name" = "vpc-private-subnet-3"
      }
  - tags_all = {
    - "Name" = "vpc-private-subnet-3"
      }
  - vpc_id = (known after apply)
    }

# module.vpc.aws_subnet.public[0] will be created

- resource "aws_subnet" "public" {
  - arn = (known after apply)
  - assign_ipv6_address_on_creation = false
  - availability_zone = "us-west-2a"
  - availability_zone_id = (known after apply)
  - cidr_block = "10.0.1.0/24"
  - enable_dns64 = false
  - enable_resource_name_dns_a_record_on_launch = false
  - enable_resource_name_dns_aaaa_record_on_launch = false
  - id = (known after apply)
  - ipv6_cidr_block_association_id = (known after apply)
  - ipv6_native = false
  - map_public_ip_on_launch = true
  - owner_id = (known after apply)
  - private_dns_hostname_type_on_launch = (known after apply)
  - tags = {
    - "Name" = "vpc-public-subnet-1"
      }
  - tags_all = {
    - "Name" = "vpc-public-subnet-1"
      }
  - vpc_id = (known after apply)
    }

# module.vpc.aws_subnet.public[1] will be created

- resource "aws_subnet" "public" {
  - arn = (known after apply)
  - assign_ipv6_address_on_creation = false
  - availability_zone = "us-west-2b"
  - availability_zone_id = (known after apply)
  - cidr_block = "10.0.2.0/24"
  - enable_dns64 = false
  - enable_resource_name_dns_a_record_on_launch = false
  - enable_resource_name_dns_aaaa_record_on_launch = false
  - id = (known after apply)
  - ipv6_cidr_block_association_id = (known after apply)
  - ipv6_native = false
  - map_public_ip_on_launch = true
  - owner_id = (known after apply)
  - private_dns_hostname_type_on_launch = (known after apply)
  - tags = {
    - "Name" = "vpc-public-subnet-2"
      }
  - tags_all = {
    - "Name" = "vpc-public-subnet-2"
      }
  - vpc_id = (known after apply)
    }

# module.vpc.aws_subnet.public[2] will be created

- resource "aws_subnet" "public" {
  - arn = (known after apply)
  - assign_ipv6_address_on_creation = false
  - availability_zone = "us-west-2c"
  - availability_zone_id = (known after apply)
  - cidr_block = "10.0.3.0/24"
  - enable_dns64 = false
  - enable_resource_name_dns_a_record_on_launch = false
  - enable_resource_name_dns_aaaa_record_on_launch = false
  - id = (known after apply)
  - ipv6_cidr_block_association_id = (known after apply)
  - ipv6_native = false
  - map_public_ip_on_launch = true
  - owner_id = (known after apply)
  - private_dns_hostname_type_on_launch = (known after apply)
  - tags = {
    - "Name" = "vpc-public-subnet-3"
      }
  - tags_all = {
    - "Name" = "vpc-public-subnet-3"
      }
  - vpc_id = (known after apply)
    }

# module.vpc.aws_vpc.main will be created

- resource "aws_vpc" "main" {
  - arn = (known after apply)
  - cidr_block = "10.0.0.0/16"
  - default_network_acl_id = (known after apply)
  - default_route_table_id = (known after apply)
  - default_security_group_id = (known after apply)
  - dhcp_options_id = (known after apply)
  - enable_dns_hostnames = true
  - enable_dns_support = true
  - enable_network_address_usage_metrics = (known after apply)
  - id = (known after apply)
  - instance_tenancy = "default"
  - ipv6_association_id = (known after apply)
  - ipv6_cidr_block = (known after apply)
  - ipv6_cidr_block_network_border_group = (known after apply)
  - main_route_table_id = (known after apply)
  - owner_id = (known after apply)
  - tags = {
    - "Name" = "vpc-vpc"
      }
  - tags_all = { + "Name" = "vpc-vpc"
    }
    }

Plan: 27 to add, 0 to change, 0 to destroy.

Changes to Outputs:

- dynamodb_table_name = "terraform-locks"
- ecr_repository_url = (known after apply)
- private_subnet_ids = [
  - (known after apply),
  - (known after apply),
  - (known after apply),
    ]
- public_subnet_ids = [
  - (known after apply),
  - (known after apply),
  - (known after apply),
    ]
- s3_bucket_name = "terraform-state-inna-boiko-2026"
- vpc_id = (known after apply)

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
inna@iMac-di-Inna my-microservice-project % terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:

- create

Terraform will perform the following actions:

# module.ecr.aws_ecr_lifecycle_policy.this will be created

- resource "aws_ecr_lifecycle_policy" "this" {
  - id = (known after apply)
  - policy = jsonencode(
    { + rules = [
    + {
    + action = {
    + type = "expire"
    }
    + description = "Keep only the last 10 images"
    + rulePriority = 1
    + selection = {
    + countNumber = 10
    + countType = "imageCountMoreThan"
    + tagStatus = "any"
    }
    },
    ]
    }
    )
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
  - tags = {
    - "ManagedBy" = "Terraform"
    - "Name" = "lesson-5-ecr"
    - "Project" = "lesson-5"
      }
  - tags_all = {
    - "ManagedBy" = "Terraform"
    - "Name" = "lesson-5-ecr"
    - "Project" = "lesson-5"
      }

  - image_scanning_configuration { + scan_on_push = true
    }
    }

# module.ecr.aws_ecr_repository_policy.this will be created

- resource "aws_ecr_repository_policy" "this" {
  - id = (known after apply)
  - policy = jsonencode(
    { + Statement = [ + { + Action = [
    + "ecr:GetDownloadUrlForLayer",
    + "ecr:BatchGetImage",
    + "ecr:BatchCheckLayerAvailability",
    + "ecr:PutImage",
    + "ecr:InitiateLayerUpload",
    + "ecr:UploadLayerPart",
    + "ecr:CompleteLayerUpload",
    ] + Effect = "Allow" + Principal = { + AWS = "\*"
    } + Sid = "AllowPushPull"
    },
    ] + Version = "2008-10-17"
    }
    )
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
  - read_capacity = (known after apply)
  - stream_arn = (known after apply)
  - stream_label = (known after apply)
  - stream_view_type = (known after apply)
  - tags = {
    - "Environment" = "lesson-5"
    - "Name" = "Terraform Lock Table"
      }
  - tags_all = {
    - "Environment" = "lesson-5"
    - "Name" = "Terraform Lock Table"
      }
  - write_capacity = (known after apply)

  - attribute {
    - name = "LockID"
    - type = "S"
      }

  - point_in_time_recovery (known after apply)

  - server_side_encryption (known after apply)

  - ttl (known after apply)
    }

# module.s3_backend.aws_s3_bucket.terraform_state will be created

- resource "aws_s3_bucket" "terraform_state" {
  - acceleration_status = (known after apply)
  - acl = (known after apply)
  - arn = (known after apply)
  - bucket = "terraform-state-inna-boiko-2026"
  - bucket_domain_name = (known after apply)
  - bucket_prefix = (known after apply)
  - bucket_regional_domain_name = (known after apply)
  - force_destroy = false
  - hosted_zone_id = (known after apply)
  - id = (known after apply)
  - object_lock_enabled = (known after apply)
  - policy = (known after apply)
  - region = (known after apply)
  - request_payer = (known after apply)
  - tags = {
    - "Environment" = "lesson-5"
    - "Name" = "Terraform State Bucket"
      }
  - tags_all = {
    - "Environment" = "lesson-5"
    - "Name" = "Terraform State Bucket"
      }
  - website_domain = (known after apply)
  - website_endpoint = (known after apply)

  - cors_rule (known after apply)

  - grant (known after apply)

  - lifecycle_rule (known after apply)

  - logging (known after apply)

  - object_lock_configuration (known after apply)

  - replication_configuration (known after apply)

  - server_side_encryption_configuration (known after apply)

  - versioning (known after apply)

  - website (known after apply)
    }

# module.s3_backend.aws_s3_bucket_ownership_controls.terraform_state_ownership will be created

- resource "aws_s3_bucket_ownership_controls" "terraform_state_ownership" {
  - bucket = (known after apply)
  - id = (known after apply)

  - rule { + object_ownership = "BucketOwnerEnforced"
    }
    }

# module.s3_backend.aws_s3_bucket_versioning.terraform_state_versioning will be created

- resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  - bucket = (known after apply)
  - id = (known after apply)

  - versioning_configuration { + mfa_delete = (known after apply) + status = "Enabled"
    }
    }

# module.vpc.aws_eip.nat will be created

- resource "aws_eip" "nat" {
  - allocation_id = (known after apply)
  - arn = (known after apply)
  - association_id = (known after apply)
  - carrier_ip = (known after apply)
  - customer_owned_ip = (known after apply)
  - domain = "vpc"
  - id = (known after apply)
  - instance = (known after apply)
  - ipam_pool_id = (known after apply)
  - network_border_group = (known after apply)
  - network_interface = (known after apply)
  - private_dns = (known after apply)
  - private_ip = (known after apply)
  - ptr_record = (known after apply)
  - public_dns = (known after apply)
  - public_ip = (known after apply)
  - public_ipv4_pool = (known after apply)
  - tags = {
    - "Name" = "vpc-nat-eip"
      }
  - tags_all = {
    - "Name" = "vpc-nat-eip"
      }
  - vpc = (known after apply)
    }

# module.vpc.aws_internet_gateway.igw will be created

- resource "aws_internet_gateway" "igw" {
  - arn = (known after apply)
  - id = (known after apply)
  - owner_id = (known after apply)
  - tags = {
    - "Name" = "vpc-igw"
      }
  - tags_all = {
    - "Name" = "vpc-igw"
      }
  - vpc_id = (known after apply)
    }

# module.vpc.aws_nat_gateway.nat will be created

- resource "aws_nat_gateway" "nat" {
  - allocation_id = (known after apply)
  - association_id = (known after apply)
  - connectivity_type = "public"
  - id = (known after apply)
  - network_interface_id = (known after apply)
  - private_ip = (known after apply)
  - public_ip = (known after apply)
  - secondary_private_ip_address_count = (known after apply)
  - secondary_private_ip_addresses = (known after apply)
  - subnet_id = (known after apply)
  - tags = {
    - "Name" = "vpc-nat"
      }
  - tags_all = { + "Name" = "vpc-nat"
    }
    }

# module.vpc.aws_route.private_nat will be created

- resource "aws_route" "private_nat" {
  - destination_cidr_block = "0.0.0.0/0"
  - id = (known after apply)
  - instance_id = (known after apply)
  - instance_owner_id = (known after apply)
  - nat_gateway_id = (known after apply)
  - network_interface_id = (known after apply)
  - origin = (known after apply)
  - route_table_id = (known after apply)
  - state = (known after apply)
    }

# module.vpc.aws_route.public_internet will be created

- resource "aws_route" "public_internet" {
  - destination_cidr_block = "0.0.0.0/0"
  - gateway_id = (known after apply)
  - id = (known after apply)
  - instance_id = (known after apply)
  - instance_owner_id = (known after apply)
  - network_interface_id = (known after apply)
  - origin = (known after apply)
  - route_table_id = (known after apply)
  - state = (known after apply)
    }

# module.vpc.aws_route_table.private will be created

- resource "aws_route_table" "private" {
  - arn = (known after apply)
  - id = (known after apply)
  - owner_id = (known after apply)
  - propagating_vgws = (known after apply)
  - route = (known after apply)
  - tags = {
    - "Name" = "vpc-private-rt"
      }
  - tags_all = {
    - "Name" = "vpc-private-rt"
      }
  - vpc_id = (known after apply)
    }

# module.vpc.aws_route_table.public will be created

- resource "aws_route_table" "public" {
  - arn = (known after apply)
  - id = (known after apply)
  - owner_id = (known after apply)
  - propagating_vgws = (known after apply)
  - route = (known after apply)
  - tags = {
    - "Name" = "vpc-public-rt"
      }
  - tags_all = {
    - "Name" = "vpc-public-rt"
      }
  - vpc_id = (known after apply)
    }

# module.vpc.aws_route_table_association.private[0] will be created

- resource "aws_route_table_association" "private" {
  - id = (known after apply)
  - route_table_id = (known after apply)
  - subnet_id = (known after apply)
    }

# module.vpc.aws_route_table_association.private[1] will be created

- resource "aws_route_table_association" "private" {
  - id = (known after apply)
  - route_table_id = (known after apply)
  - subnet_id = (known after apply)
    }

# module.vpc.aws_route_table_association.private[2] will be created

- resource "aws_route_table_association" "private" {
  - id = (known after apply)
  - route_table_id = (known after apply)
  - subnet_id = (known after apply)
    }

# module.vpc.aws_route_table_association.public[0] will be created

- resource "aws_route_table_association" "public" {
  - id = (known after apply)
  - route_table_id = (known after apply)
  - subnet_id = (known after apply)
    }

# module.vpc.aws_route_table_association.public[1] will be created

- resource "aws_route_table_association" "public" {
  - id = (known after apply)
  - route_table_id = (known after apply)
  - subnet_id = (known after apply)
    }

# module.vpc.aws_route_table_association.public[2] will be created

- resource "aws_route_table_association" "public" {
  - id = (known after apply)
  - route_table_id = (known after apply)
  - subnet_id = (known after apply)
    }

# module.vpc.aws_subnet.private[0] will be created

- resource "aws_subnet" "private" {
  - arn = (known after apply)
  - assign_ipv6_address_on_creation = false
  - availability_zone = "us-west-2a"
  - availability_zone_id = (known after apply)
  - cidr_block = "10.0.4.0/24"
  - enable_dns64 = false
  - enable_resource_name_dns_a_record_on_launch = false
  - enable_resource_name_dns_aaaa_record_on_launch = false
  - id = (known after apply)
  - ipv6_cidr_block_association_id = (known after apply)
  - ipv6_native = false
  - map_public_ip_on_launch = false
  - owner_id = (known after apply)
  - private_dns_hostname_type_on_launch = (known after apply)
  - tags = {
    - "Name" = "vpc-private-subnet-1"
      }
  - tags_all = {
    - "Name" = "vpc-private-subnet-1"
      }
  - vpc_id = (known after apply)
    }

# module.vpc.aws_subnet.private[1] will be created

- resource "aws_subnet" "private" {
  - arn = (known after apply)
  - assign_ipv6_address_on_creation = false
  - availability_zone = "us-west-2b"
  - availability_zone_id = (known after apply)
  - cidr_block = "10.0.5.0/24"
  - enable_dns64 = false
  - enable_resource_name_dns_a_record_on_launch = false
  - enable_resource_name_dns_aaaa_record_on_launch = false
  - id = (known after apply)
  - ipv6_cidr_block_association_id = (known after apply)
  - ipv6_native = false
  - map_public_ip_on_launch = false
  - owner_id = (known after apply)
  - private_dns_hostname_type_on_launch = (known after apply)
  - tags = {
    - "Name" = "vpc-private-subnet-2"
      }
  - tags_all = {
    - "Name" = "vpc-private-subnet-2"
      }
  - vpc_id = (known after apply)
    }

# module.vpc.aws_subnet.private[2] will be created

- resource "aws_subnet" "private" {
  - arn = (known after apply)
  - assign_ipv6_address_on_creation = false
  - availability_zone = "us-west-2c"
  - availability_zone_id = (known after apply)
  - cidr_block = "10.0.6.0/24"
  - enable_dns64 = false
  - enable_resource_name_dns_a_record_on_launch = false
  - enable_resource_name_dns_aaaa_record_on_launch = false
  - id = (known after apply)
  - ipv6_cidr_block_association_id = (known after apply)
  - ipv6_native = false
  - map_public_ip_on_launch = false
  - owner_id = (known after apply)
  - private_dns_hostname_type_on_launch = (known after apply)
  - tags = {
    - "Name" = "vpc-private-subnet-3"
      }
  - tags_all = {
    - "Name" = "vpc-private-subnet-3"
      }
  - vpc_id = (known after apply)
    }

# module.vpc.aws_subnet.public[0] will be created

- resource "aws_subnet" "public" {
  - arn = (known after apply)
  - assign_ipv6_address_on_creation = false
  - availability_zone = "us-west-2a"
  - availability_zone_id = (known after apply)
  - cidr_block = "10.0.1.0/24"
  - enable_dns64 = false
  - enable_resource_name_dns_a_record_on_launch = false
  - enable_resource_name_dns_aaaa_record_on_launch = false
  - id = (known after apply)
  - ipv6_cidr_block_association_id = (known after apply)
  - ipv6_native = false
  - map_public_ip_on_launch = true
  - owner_id = (known after apply)
  - private_dns_hostname_type_on_launch = (known after apply)
  - tags = {
    - "Name" = "vpc-public-subnet-1"
      }
  - tags_all = {
    - "Name" = "vpc-public-subnet-1"
      }
  - vpc_id = (known after apply)
    }

# module.vpc.aws_subnet.public[1] will be created

- resource "aws_subnet" "public" {
  - arn = (known after apply)
  - assign_ipv6_address_on_creation = false
  - availability_zone = "us-west-2b"
  - availability_zone_id = (known after apply)
  - cidr_block = "10.0.2.0/24"
  - enable_dns64 = false
  - enable_resource_name_dns_a_record_on_launch = false
  - enable_resource_name_dns_aaaa_record_on_launch = false
  - id = (known after apply)
  - ipv6_cidr_block_association_id = (known after apply)
  - ipv6_native = false
  - map_public_ip_on_launch = true
  - owner_id = (known after apply)
  - private_dns_hostname_type_on_launch = (known after apply)
  - tags = {
    - "Name" = "vpc-public-subnet-2"
      }
  - tags_all = {
    - "Name" = "vpc-public-subnet-2"
      }
  - vpc_id = (known after apply)
    }

# module.vpc.aws_subnet.public[2] will be created

- resource "aws_subnet" "public" {
  - arn = (known after apply)
  - assign_ipv6_address_on_creation = false
  - availability_zone = "us-west-2c"
  - availability_zone_id = (known after apply)
  - cidr_block = "10.0.3.0/24"
  - enable_dns64 = false
  - enable_resource_name_dns_a_record_on_launch = false
  - enable_resource_name_dns_aaaa_record_on_launch = false
  - id = (known after apply)
  - ipv6_cidr_block_association_id = (known after apply)
  - ipv6_native = false
  - map_public_ip_on_launch = true
  - owner_id = (known after apply)
  - private_dns_hostname_type_on_launch = (known after apply)
  - tags = {
    - "Name" = "vpc-public-subnet-3"
      }
  - tags_all = {
    - "Name" = "vpc-public-subnet-3"
      }
  - vpc_id = (known after apply)
    }

# module.vpc.aws_vpc.main will be created

- resource "aws_vpc" "main" {
  - arn = (known after apply)
  - cidr_block = "10.0.0.0/16"
  - default_network_acl_id = (known after apply)
  - default_route_table_id = (known after apply)
  - default_security_group_id = (known after apply)
  - dhcp_options_id = (known after apply)
  - enable_dns_hostnames = true
  - enable_dns_support = true
  - enable_network_address_usage_metrics = (known after apply)
  - id = (known after apply)
  - instance_tenancy = "default"
  - ipv6_association_id = (known after apply)
  - ipv6_cidr_block = (known after apply)
  - ipv6_cidr_block_network_border_group = (known after apply)
  - main_route_table_id = (known after apply)
  - owner_id = (known after apply)
  - tags = {
    - "Name" = "vpc-vpc"
      }
  - tags_all = { + "Name" = "vpc-vpc"
    }
    }

Plan: 27 to add, 0 to change, 0 to destroy.

Changes to Outputs:

- dynamodb_table_name = "terraform-locks"
- ecr_repository_url = (known after apply)
- private_subnet_ids = [
  - (known after apply),
  - (known after apply),
  - (known after apply),
    ]
- public_subnet_ids = [
  - (known after apply),
  - (known after apply),
  - (known after apply),
    ]
- s3_bucket_name = "terraform-state-inna-boiko-2026"
- vpc_id = (known after apply)

Do you want to perform these actions?
Terraform will perform the actions described above.
Only 'yes' will be accepted to approve.

Enter a value: yes

module.vpc.aws_vpc.main: Creating...
module.ecr.aws_ecr_repository.this: Creating...
module.s3_backend.aws_dynamodb_table.terraform_locks: Creating...
module.s3_backend.aws_s3_bucket.terraform_state: Creating...
module.ecr.aws_ecr_repository.this: Creation complete after 2s [id=lesson-5-ecr]
module.ecr.aws_ecr_repository_policy.this: Creating...
module.ecr.aws_ecr_lifecycle_policy.this: Creating...
module.ecr.aws_ecr_lifecycle_policy.this: Creation complete after 1s [id=lesson-5-ecr]
module.ecr.aws_ecr_repository_policy.this: Creation complete after 1s [id=lesson-5-ecr]
module.s3_backend.aws_s3_bucket.terraform_state: Creation complete after 7s [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_ownership_controls.terraform_state_ownership: Creating...
module.s3_backend.aws_s3_bucket_versioning.terraform_state_versioning: Creating...
module.s3_backend.aws_s3_bucket_ownership_controls.terraform_state_ownership: Creation complete after 1s [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_versioning.terraform_state_versioning: Creation complete after 2s [id=terraform-state-inna-boiko-2026]
module.vpc.aws_vpc.main: Still creating... [00m10s elapsed]
module.s3_backend.aws_dynamodb_table.terraform_locks: Still creating... [00m10s elapsed]
module.s3_backend.aws_dynamodb_table.terraform_locks: Creation complete after 11s [id=terraform-locks]
module.vpc.aws_vpc.main: Creation complete after 15s [id=vpc-0e2f029512e7fdfb6]
module.vpc.aws_route_table.public: Creating...
module.vpc.aws_subnet.public[1]: Creating...
module.vpc.aws_internet_gateway.igw: Creating...
module.vpc.aws_subnet.private[0]: Creating...
module.vpc.aws_subnet.public[0]: Creating...
module.vpc.aws_route_table.private: Creating...
module.vpc.aws_subnet.private[1]: Creating...
module.vpc.aws_subnet.private[2]: Creating...
module.vpc.aws_subnet.public[2]: Creating...
module.vpc.aws_route_table.public: Creation complete after 2s [id=rtb-0e9865c72165c4fcf]
module.vpc.aws_internet_gateway.igw: Creation complete after 2s [id=igw-02a6651c2df4b691d]
module.vpc.aws_route.public_internet: Creating...
module.vpc.aws_eip.nat: Creating...
module.vpc.aws_route_table.private: Creation complete after 2s [id=rtb-0161ff75ba4c5fa61]
module.vpc.aws_subnet.private[1]: Creation complete after 2s [id=subnet-0e15bab1300ef14b9]
module.vpc.aws_route.public_internet: Creation complete after 2s [id=r-rtb-0e9865c72165c4fcf1080289494]
module.vpc.aws_eip.nat: Creation complete after 2s [id=eipalloc-08985452023a81519]
module.vpc.aws_subnet.private[2]: Creation complete after 5s [id=subnet-04f5032aefdc2768a]
module.vpc.aws_subnet.private[0]: Creation complete after 10s [id=subnet-0cfa129338fb27e1a]
module.vpc.aws_route_table_association.private[0]: Creating...
module.vpc.aws_route_table_association.private[1]: Creating...
module.vpc.aws_route_table_association.private[2]: Creating...
module.vpc.aws_subnet.public[1]: Still creating... [00m10s elapsed]
module.vpc.aws_subnet.public[0]: Still creating... [00m10s elapsed]
module.vpc.aws_subnet.public[2]: Still creating... [00m10s elapsed]
module.vpc.aws_route_table_association.private[0]: Creation complete after 1s [id=rtbassoc-003b9da4406ee0018]
module.vpc.aws_route_table_association.private[2]: Creation complete after 1s [id=rtbassoc-0667eb8e05c1305ed]
module.vpc.aws_route_table_association.private[1]: Creation complete after 1s [id=rtbassoc-0a1e3e6f4c34aa53b]
module.vpc.aws_subnet.public[2]: Creation complete after 13s [id=subnet-05166c5a650f638b9]
module.vpc.aws_subnet.public[1]: Creation complete after 13s [id=subnet-0d85a65f400c62eb7]
module.vpc.aws_subnet.public[0]: Creation complete after 15s [id=subnet-0b16f520d238de4af]
module.vpc.aws_route_table_association.public[1]: Creating...
module.vpc.aws_route_table_association.public[0]: Creating...
module.vpc.aws_route_table_association.public[2]: Creating...
module.vpc.aws_nat_gateway.nat: Creating...
module.vpc.aws_route_table_association.public[2]: Creation complete after 1s [id=rtbassoc-0564e5ad9ea16ebbd]
module.vpc.aws_route_table_association.public[0]: Creation complete after 1s [id=rtbassoc-0150e8ae474afa452]
module.vpc.aws_route_table_association.public[1]: Creation complete after 1s [id=rtbassoc-004e4a6fbae134dfd]
module.vpc.aws_nat_gateway.nat: Still creating... [00m10s elapsed]
module.vpc.aws_nat_gateway.nat: Still creating... [00m20s elapsed]
module.vpc.aws_nat_gateway.nat: Still creating... [00m30s elapsed]
module.vpc.aws_nat_gateway.nat: Still creating... [00m40s elapsed]
module.vpc.aws_nat_gateway.nat: Still creating... [00m50s elapsed]
module.vpc.aws_nat_gateway.nat: Still creating... [01m00s elapsed]
module.vpc.aws_nat_gateway.nat: Still creating... [01m10s elapsed]
module.vpc.aws_nat_gateway.nat: Still creating... [01m20s elapsed]
module.vpc.aws_nat_gateway.nat: Still creating... [01m30s elapsed]
module.vpc.aws_nat_gateway.nat: Creation complete after 1m37s [id=nat-00b637f9aad6e0540]
module.vpc.aws_route.private_nat: Creating...
module.vpc.aws_route.private_nat: Creation complete after 2s [id=r-rtb-0161ff75ba4c5fa611080289494]

Apply complete! Resources: 27 added, 0 changed, 0 destroyed.

Outputs:

dynamodb_table_name = "terraform-locks"
ecr_repository_url = "740948698725.dkr.ecr.us-west-2.amazonaws.com/lesson-5-ecr"
private_subnet_ids = [
"subnet-0cfa129338fb27e1a",
"subnet-0e15bab1300ef14b9",
"subnet-04f5032aefdc2768a",
]
public_subnet_ids = [
"subnet-0b16f520d238de4af",
"subnet-0d85a65f400c62eb7",
"subnet-05166c5a650f638b9",
]
s3_bucket_name = "terraform-state-inna-boiko-2026"
vpc_id = "vpc-0e2f029512e7fdfb6"
