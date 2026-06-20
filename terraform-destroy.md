# Terraform destroy — output (lesson-5)

**Command:** `terraform destroy`
**Region:** us-west-2 — **Account:** 740948698725

**Result:** `Destroy complete! Resources: 27 destroyed.`

All resources were removed after testing, to avoid further AWS charges.

---

```text
inna@iMac-di-Inna my-microservice-project % terraform destroy
module.vpc.aws_vpc.main: Refreshing state... [id=vpc-0e2f029512e7fdfb6]
module.ecr.aws_ecr_repository.this: Refreshing state... [id=lesson-5-ecr]
module.s3_backend.aws_dynamodb_table.terraform_locks: Refreshing state... [id=terraform-locks]
module.s3_backend.aws_s3_bucket.terraform_state: Refreshing state... [id=terraform-state-inna-boiko-2026]
module.ecr.aws_ecr_lifecycle_policy.this: Refreshing state... [id=lesson-5-ecr]
module.ecr.aws_ecr_repository_policy.this: Refreshing state... [id=lesson-5-ecr]
module.vpc.aws_route_table.public: Refreshing state... [id=rtb-0e9865c72165c4fcf]
module.vpc.aws_route_table.private: Refreshing state... [id=rtb-0161ff75ba4c5fa61]
module.vpc.aws_internet_gateway.igw: Refreshing state... [id=igw-02a6651c2df4b691d]
module.vpc.aws_subnet.public[2]: Refreshing state... [id=subnet-05166c5a650f638b9]
module.vpc.aws_subnet.private[1]: Refreshing state... [id=subnet-0e15bab1300ef14b9]
module.vpc.aws_subnet.public[1]: Refreshing state... [id=subnet-0d85a65f400c62eb7]
module.vpc.aws_subnet.private[2]: Refreshing state... [id=subnet-04f5032aefdc2768a]
module.vpc.aws_subnet.private[0]: Refreshing state... [id=subnet-0cfa129338fb27e1a]
module.vpc.aws_subnet.public[0]: Refreshing state... [id=subnet-0b16f520d238de4af]
module.vpc.aws_eip.nat: Refreshing state... [id=eipalloc-08985452023a81519]
module.vpc.aws_route.public_internet: Refreshing state... [id=r-rtb-0e9865c72165c4fcf1080289494]
module.vpc.aws_route_table_association.private[1]: Refreshing state... [id=rtbassoc-0a1e3e6f4c34aa53b]
module.vpc.aws_route_table_association.private[2]: Refreshing state... [id=rtbassoc-0667eb8e05c1305ed]
module.vpc.aws_route_table_association.private[0]: Refreshing state... [id=rtbassoc-003b9da4406ee0018]
module.vpc.aws_route_table_association.public[1]: Refreshing state... [id=rtbassoc-004e4a6fbae134dfd]
module.vpc.aws_route_table_association.public[0]: Refreshing state... [id=rtbassoc-0150e8ae474afa452]
module.vpc.aws_route_table_association.public[2]: Refreshing state... [id=rtbassoc-0564e5ad9ea16ebbd]
module.s3_backend.aws_s3_bucket_ownership_controls.terraform_state_ownership: Refreshing state... [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_versioning.terraform_state_versioning: Refreshing state... [id=terraform-state-inna-boiko-2026]
module.vpc.aws_nat_gateway.nat: Refreshing state... [id=nat-00b637f9aad6e0540]
module.vpc.aws_route.private_nat: Refreshing state... [id=r-rtb-0161ff75ba4c5fa611080289494]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:

- destroy

Terraform will perform the following actions:

# module.ecr.aws_ecr_lifecycle_policy.this will be destroyed

- resource "aws_ecr_lifecycle_policy" "this" {
  - id = "lesson-5-ecr" -> null
  - policy = jsonencode(
    { - rules = [
    - {
    - action = {
    - type = "expire"
      }
    - description = "Keep only the last 10 images"
    - rulePriority = 1
    - selection = {
    - countNumber = 10
    - countType = "imageCountMoreThan"
    - tagStatus = "any"
      }
      },
      ]
      }
      ) -> null
  - registry_id = "740948698725" -> null
  - repository = "lesson-5-ecr" -> null
    }

# module.ecr.aws_ecr_repository.this will be destroyed

- resource "aws_ecr_repository" "this" {
  - arn = "arn:aws:ecr:us-west-2:740948698725:repository/lesson-5-ecr" -> null
  - force_delete = false -> null
  - id = "lesson-5-ecr" -> null
  - image_tag_mutability = "MUTABLE" -> null
  - name = "lesson-5-ecr" -> null
  - registry_id = "740948698725" -> null
  - repository_url = "740948698725.dkr.ecr.us-west-2.amazonaws.com/lesson-5-ecr" -> null
  - tags = {
    - "ManagedBy" = "Terraform"
    - "Name" = "lesson-5-ecr"
    - "Project" = "lesson-5"
      } -> null
  - tags_all = {
    - "ManagedBy" = "Terraform"
    - "Name" = "lesson-5-ecr"
    - "Project" = "lesson-5"
      } -> null

  - encryption_configuration {
    - encryption_type = "AES256" -> null # (1 unchanged attribute hidden)
      }

  - image_scanning_configuration { - scan_on_push = true -> null
    }
    }

# module.ecr.aws_ecr_repository_policy.this will be destroyed

- resource "aws_ecr_repository_policy" "this" {
  - id = "lesson-5-ecr" -> null
  - policy = jsonencode(
    { - Statement = [ - { - Action = [
    - "ecr:GetDownloadUrlForLayer",
    - "ecr:BatchGetImage",
    - "ecr:BatchCheckLayerAvailability",
    - "ecr:PutImage",
    - "ecr:InitiateLayerUpload",
    - "ecr:UploadLayerPart",
    - "ecr:CompleteLayerUpload",
      ] - Effect = "Allow" - Principal = { - AWS = "\*"
      } - Sid = "AllowPushPull"
      },
      ] - Version = "2008-10-17"
      }
      ) -> null
  - registry_id = "740948698725" -> null
  - repository = "lesson-5-ecr" -> null
    }

# module.s3_backend.aws_dynamodb_table.terraform_locks will be destroyed

- resource "aws_dynamodb_table" "terraform_locks" {
  - arn = "arn:aws:dynamodb:us-west-2:740948698725:table/terraform-locks" -> null
  - billing_mode = "PAY_PER_REQUEST" -> null
  - deletion_protection_enabled = false -> null
  - hash_key = "LockID" -> null
  - id = "terraform-locks" -> null
  - name = "terraform-locks" -> null
  - read_capacity = 0 -> null
  - stream_enabled = false -> null
  - table_class = "STANDARD" -> null
  - tags = {
    - "Environment" = "lesson-5"
    - "Name" = "Terraform Lock Table"
      } -> null
  - tags_all = {
    - "Environment" = "lesson-5"
    - "Name" = "Terraform Lock Table"
      } -> null
  - write_capacity = 0 -> null

    # (3 unchanged attributes hidden)

  - attribute {
    - name = "LockID" -> null
    - type = "S" -> null
      }

  - point_in_time_recovery {
    - enabled = false -> null
    - recovery_period_in_days = 0 -> null
      }

  - ttl { - enabled = false -> null # (1 unchanged attribute hidden)
    }
    }

# module.s3_backend.aws_s3_bucket.terraform_state will be destroyed

- resource "aws_s3_bucket" "terraform_state" {
  - arn = "arn:aws:s3:::terraform-state-inna-boiko-2026" -> null
  - bucket = "terraform-state-inna-boiko-2026" -> null
  - bucket_domain_name = "terraform-state-inna-boiko-2026.s3.amazonaws.com" -> null
  - bucket_regional_domain_name = "terraform-state-inna-boiko-2026.s3.us-west-2.amazonaws.com" -> null
  - force_destroy = false -> null
  - hosted_zone_id = "Z3BJ6K6RIION7M" -> null
  - id = "terraform-state-inna-boiko-2026" -> null
  - object_lock_enabled = false -> null
  - region = "us-west-2" -> null
  - request_payer = "BucketOwner" -> null
  - tags = {
    - "Environment" = "lesson-5"
    - "Name" = "Terraform State Bucket"
      } -> null
  - tags_all = {
    - "Environment" = "lesson-5"
    - "Name" = "Terraform State Bucket"
      } -> null

    # (3 unchanged attributes hidden)

  - grant {
    - id = "42134411473e9204803649897efc898b32769966a5668fedec0af7679598f3f0" -> null
    - permissions = [
      - "FULL_CONTROL",
        ] -> null
    - type = "CanonicalUser" -> null # (1 unchanged attribute hidden)
      }

  - server_side_encryption_configuration {
    - rule { - bucket_key_enabled = false -> null

            - apply_server_side_encryption_by_default {
                - sse_algorithm     = "AES256" -> null
                  # (1 unchanged attribute hidden)
              }
          }

      }

  - versioning { - enabled = true -> null - mfa_delete = false -> null
    }
    }

# module.s3_backend.aws_s3_bucket_ownership_controls.terraform_state_ownership will be destroyed

- resource "aws_s3_bucket_ownership_controls" "terraform_state_ownership" {
  - bucket = "terraform-state-inna-boiko-2026" -> null
  - id = "terraform-state-inna-boiko-2026" -> null

  - rule { - object_ownership = "BucketOwnerEnforced" -> null
    }
    }

# module.s3_backend.aws_s3_bucket_versioning.terraform_state_versioning will be destroyed

- resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  - bucket = "terraform-state-inna-boiko-2026" -> null
  - id = "terraform-state-inna-boiko-2026" -> null

    # (1 unchanged attribute hidden)

  - versioning_configuration { - status = "Enabled" -> null # (1 unchanged attribute hidden)
    }
    }

# module.vpc.aws_eip.nat will be destroyed

- resource "aws_eip" "nat" {
  - allocation_id = "eipalloc-08985452023a81519" -> null
  - arn = "arn:aws:ec2:us-west-2:740948698725:elastic-ip/eipalloc-08985452023a81519" -> null
  - association_id = "eipassoc-0af097831f5e955eb" -> null
  - domain = "vpc" -> null
  - id = "eipalloc-08985452023a81519" -> null
  - network_border_group = "us-west-2" -> null
  - network_interface = "eni-05d2a2d98cc56fdab" -> null
  - private_dns = "ip-10-0-1-253.us-west-2.compute.internal" -> null
  - private_ip = "10.0.1.253" -> null
  - public_dns = "ec2-54-214-147-233.us-west-2.compute.amazonaws.com" -> null
  - public_ip = "54.214.147.233" -> null
  - public_ipv4_pool = "amazon" -> null
  - tags = {
    - "Name" = "vpc-nat-eip"
      } -> null
  - tags_all = {
    - "Name" = "vpc-nat-eip"
      } -> null
  - vpc = true -> null # (5 unchanged attributes hidden)
    }

# module.vpc.aws_internet_gateway.igw will be destroyed

- resource "aws_internet_gateway" "igw" {
  - arn = "arn:aws:ec2:us-west-2:740948698725:internet-gateway/igw-02a6651c2df4b691d" -> null
  - id = "igw-02a6651c2df4b691d" -> null
  - owner_id = "740948698725" -> null
  - tags = {
    - "Name" = "vpc-igw"
      } -> null
  - tags_all = {
    - "Name" = "vpc-igw"
      } -> null
  - vpc_id = "vpc-0e2f029512e7fdfb6" -> null
    }

# module.vpc.aws_nat_gateway.nat will be destroyed

- resource "aws_nat_gateway" "nat" {
  - allocation_id = "eipalloc-08985452023a81519" -> null
  - association_id = "eipassoc-0af097831f5e955eb" -> null
  - connectivity_type = "public" -> null
  - id = "nat-00b637f9aad6e0540" -> null
  - network_interface_id = "eni-05d2a2d98cc56fdab" -> null
  - private_ip = "10.0.1.253" -> null
  - public_ip = "54.214.147.233" -> null
  - secondary_allocation_ids = [] -> null
  - secondary_private_ip_address_count = 0 -> null
  - secondary_private_ip_addresses = [] -> null
  - subnet_id = "subnet-0b16f520d238de4af" -> null
  - tags = {
    - "Name" = "vpc-nat"
      } -> null
  - tags_all = { - "Name" = "vpc-nat"
    } -> null
    }

# module.vpc.aws_route.private_nat will be destroyed

- resource "aws_route" "private_nat" {
  - destination_cidr_block = "0.0.0.0/0" -> null
  - id = "r-rtb-0161ff75ba4c5fa611080289494" -> null
  - nat_gateway_id = "nat-00b637f9aad6e0540" -> null
  - origin = "CreateRoute" -> null
  - route_table_id = "rtb-0161ff75ba4c5fa61" -> null
  - state = "active" -> null # (13 unchanged attributes hidden)
    }

# module.vpc.aws_route.public_internet will be destroyed

- resource "aws_route" "public_internet" {
  - destination_cidr_block = "0.0.0.0/0" -> null
  - gateway_id = "igw-02a6651c2df4b691d" -> null
  - id = "r-rtb-0e9865c72165c4fcf1080289494" -> null
  - origin = "CreateRoute" -> null
  - route_table_id = "rtb-0e9865c72165c4fcf" -> null
  - state = "active" -> null # (13 unchanged attributes hidden)
    }

# module.vpc.aws_route_table.private will be destroyed

- resource "aws_route_table" "private" {
  - arn = "arn:aws:ec2:us-west-2:740948698725:route-table/rtb-0161ff75ba4c5fa61" -> null
  - id = "rtb-0161ff75ba4c5fa61" -> null
  - owner_id = "740948698725" -> null
  - propagating_vgws = [] -> null
  - route = [
    - { - cidr_block = "0.0.0.0/0" - nat_gateway_id = "nat-00b637f9aad6e0540" # (11 unchanged attributes hidden)
      },
      ] -> null
  - tags = {
    - "Name" = "vpc-private-rt"
      } -> null
  - tags_all = {
    - "Name" = "vpc-private-rt"
      } -> null
  - vpc_id = "vpc-0e2f029512e7fdfb6" -> null
    }

# module.vpc.aws_route_table.public will be destroyed

- resource "aws_route_table" "public" {
  - arn = "arn:aws:ec2:us-west-2:740948698725:route-table/rtb-0e9865c72165c4fcf" -> null
  - id = "rtb-0e9865c72165c4fcf" -> null
  - owner_id = "740948698725" -> null
  - propagating_vgws = [] -> null
  - route = [
    - { - cidr_block = "0.0.0.0/0" - gateway_id = "igw-02a6651c2df4b691d" # (11 unchanged attributes hidden)
      },
      ] -> null
  - tags = {
    - "Name" = "vpc-public-rt"
      } -> null
  - tags_all = {
    - "Name" = "vpc-public-rt"
      } -> null
  - vpc_id = "vpc-0e2f029512e7fdfb6" -> null
    }

# module.vpc.aws_route_table_association.private[0] will be destroyed

- resource "aws_route_table_association" "private" {
  - id = "rtbassoc-003b9da4406ee0018" -> null
  - route_table_id = "rtb-0161ff75ba4c5fa61" -> null
  - subnet_id = "subnet-0cfa129338fb27e1a" -> null # (1 unchanged attribute hidden)
    }

# module.vpc.aws_route_table_association.private[1] will be destroyed

- resource "aws_route_table_association" "private" {
  - id = "rtbassoc-0a1e3e6f4c34aa53b" -> null
  - route_table_id = "rtb-0161ff75ba4c5fa61" -> null
  - subnet_id = "subnet-0e15bab1300ef14b9" -> null # (1 unchanged attribute hidden)
    }

# module.vpc.aws_route_table_association.private[2] will be destroyed

- resource "aws_route_table_association" "private" {
  - id = "rtbassoc-0667eb8e05c1305ed" -> null
  - route_table_id = "rtb-0161ff75ba4c5fa61" -> null
  - subnet_id = "subnet-04f5032aefdc2768a" -> null # (1 unchanged attribute hidden)
    }

# module.vpc.aws_route_table_association.public[0] will be destroyed

- resource "aws_route_table_association" "public" {
  - id = "rtbassoc-0150e8ae474afa452" -> null
  - route_table_id = "rtb-0e9865c72165c4fcf" -> null
  - subnet_id = "subnet-0b16f520d238de4af" -> null # (1 unchanged attribute hidden)
    }

# module.vpc.aws_route_table_association.public[1] will be destroyed

- resource "aws_route_table_association" "public" {
  - id = "rtbassoc-004e4a6fbae134dfd" -> null
  - route_table_id = "rtb-0e9865c72165c4fcf" -> null
  - subnet_id = "subnet-0d85a65f400c62eb7" -> null # (1 unchanged attribute hidden)
    }

# module.vpc.aws_route_table_association.public[2] will be destroyed

- resource "aws_route_table_association" "public" {
  - id = "rtbassoc-0564e5ad9ea16ebbd" -> null
  - route_table_id = "rtb-0e9865c72165c4fcf" -> null
  - subnet_id = "subnet-05166c5a650f638b9" -> null # (1 unchanged attribute hidden)
    }

# module.vpc.aws_subnet.private[0] will be destroyed

- resource "aws_subnet" "private" {
  - arn = "arn:aws:ec2:us-west-2:740948698725:subnet/subnet-0cfa129338fb27e1a" -> null
  - assign_ipv6_address_on_creation = false -> null
  - availability_zone = "us-west-2a" -> null
  - availability_zone_id = "usw2-az2" -> null
  - cidr_block = "10.0.4.0/24" -> null
  - enable_dns64 = false -> null
  - enable_lni_at_device_index = 0 -> null
  - enable_resource_name_dns_a_record_on_launch = false -> null
  - enable_resource_name_dns_aaaa_record_on_launch = false -> null
  - id = "subnet-0cfa129338fb27e1a" -> null
  - ipv6_native = false -> null
  - map_customer_owned_ip_on_launch = false -> null
  - map_public_ip_on_launch = false -> null
  - owner_id = "740948698725" -> null
  - private_dns_hostname_type_on_launch = "ip-name" -> null
  - tags = {
    - "Name" = "vpc-private-subnet-1"
      } -> null
  - tags_all = {
    - "Name" = "vpc-private-subnet-1"
      } -> null
  - vpc_id = "vpc-0e2f029512e7fdfb6" -> null # (4 unchanged attributes hidden)
    }

# module.vpc.aws_subnet.private[1] will be destroyed

- resource "aws_subnet" "private" {
  - arn = "arn:aws:ec2:us-west-2:740948698725:subnet/subnet-0e15bab1300ef14b9" -> null
  - assign_ipv6_address_on_creation = false -> null
  - availability_zone = "us-west-2b" -> null
  - availability_zone_id = "usw2-az1" -> null
  - cidr_block = "10.0.5.0/24" -> null
  - enable_dns64 = false -> null
  - enable_lni_at_device_index = 0 -> null
  - enable_resource_name_dns_a_record_on_launch = false -> null
  - enable_resource_name_dns_aaaa_record_on_launch = false -> null
  - id = "subnet-0e15bab1300ef14b9" -> null
  - ipv6_native = false -> null
  - map_customer_owned_ip_on_launch = false -> null
  - map_public_ip_on_launch = false -> null
  - owner_id = "740948698725" -> null
  - private_dns_hostname_type_on_launch = "ip-name" -> null
  - tags = {
    - "Name" = "vpc-private-subnet-2"
      } -> null
  - tags_all = {
    - "Name" = "vpc-private-subnet-2"
      } -> null
  - vpc_id = "vpc-0e2f029512e7fdfb6" -> null # (4 unchanged attributes hidden)
    }

# module.vpc.aws_subnet.private[2] will be destroyed

- resource "aws_subnet" "private" {
  - arn = "arn:aws:ec2:us-west-2:740948698725:subnet/subnet-04f5032aefdc2768a" -> null
  - assign_ipv6_address_on_creation = false -> null
  - availability_zone = "us-west-2c" -> null
  - availability_zone_id = "usw2-az3" -> null
  - cidr_block = "10.0.6.0/24" -> null
  - enable_dns64 = false -> null
  - enable_lni_at_device_index = 0 -> null
  - enable_resource_name_dns_a_record_on_launch = false -> null
  - enable_resource_name_dns_aaaa_record_on_launch = false -> null
  - id = "subnet-04f5032aefdc2768a" -> null
  - ipv6_native = false -> null
  - map_customer_owned_ip_on_launch = false -> null
  - map_public_ip_on_launch = false -> null
  - owner_id = "740948698725" -> null
  - private_dns_hostname_type_on_launch = "ip-name" -> null
  - tags = {
    - "Name" = "vpc-private-subnet-3"
      } -> null
  - tags_all = {
    - "Name" = "vpc-private-subnet-3"
      } -> null
  - vpc_id = "vpc-0e2f029512e7fdfb6" -> null # (4 unchanged attributes hidden)
    }

# module.vpc.aws_subnet.public[0] will be destroyed

- resource "aws_subnet" "public" {
  - arn = "arn:aws:ec2:us-west-2:740948698725:subnet/subnet-0b16f520d238de4af" -> null
  - assign_ipv6_address_on_creation = false -> null
  - availability_zone = "us-west-2a" -> null
  - availability_zone_id = "usw2-az2" -> null
  - cidr_block = "10.0.1.0/24" -> null
  - enable_dns64 = false -> null
  - enable_lni_at_device_index = 0 -> null
  - enable_resource_name_dns_a_record_on_launch = false -> null
  - enable_resource_name_dns_aaaa_record_on_launch = false -> null
  - id = "subnet-0b16f520d238de4af" -> null
  - ipv6_native = false -> null
  - map_customer_owned_ip_on_launch = false -> null
  - map_public_ip_on_launch = true -> null
  - owner_id = "740948698725" -> null
  - private_dns_hostname_type_on_launch = "ip-name" -> null
  - tags = {
    - "Name" = "vpc-public-subnet-1"
      } -> null
  - tags_all = {
    - "Name" = "vpc-public-subnet-1"
      } -> null
  - vpc_id = "vpc-0e2f029512e7fdfb6" -> null # (4 unchanged attributes hidden)
    }

# module.vpc.aws_subnet.public[1] will be destroyed

- resource "aws_subnet" "public" {
  - arn = "arn:aws:ec2:us-west-2:740948698725:subnet/subnet-0d85a65f400c62eb7" -> null
  - assign_ipv6_address_on_creation = false -> null
  - availability_zone = "us-west-2b" -> null
  - availability_zone_id = "usw2-az1" -> null
  - cidr_block = "10.0.2.0/24" -> null
  - enable_dns64 = false -> null
  - enable_lni_at_device_index = 0 -> null
  - enable_resource_name_dns_a_record_on_launch = false -> null
  - enable_resource_name_dns_aaaa_record_on_launch = false -> null
  - id = "subnet-0d85a65f400c62eb7" -> null
  - ipv6_native = false -> null
  - map_customer_owned_ip_on_launch = false -> null
  - map_public_ip_on_launch = true -> null
  - owner_id = "740948698725" -> null
  - private_dns_hostname_type_on_launch = "ip-name" -> null
  - tags = {
    - "Name" = "vpc-public-subnet-2"
      } -> null
  - tags_all = {
    - "Name" = "vpc-public-subnet-2"
      } -> null
  - vpc_id = "vpc-0e2f029512e7fdfb6" -> null # (4 unchanged attributes hidden)
    }

# module.vpc.aws_subnet.public[2] will be destroyed

- resource "aws_subnet" "public" {
  - arn = "arn:aws:ec2:us-west-2:740948698725:subnet/subnet-05166c5a650f638b9" -> null
  - assign_ipv6_address_on_creation = false -> null
  - availability_zone = "us-west-2c" -> null
  - availability_zone_id = "usw2-az3" -> null
  - cidr_block = "10.0.3.0/24" -> null
  - enable_dns64 = false -> null
  - enable_lni_at_device_index = 0 -> null
  - enable_resource_name_dns_a_record_on_launch = false -> null
  - enable_resource_name_dns_aaaa_record_on_launch = false -> null
  - id = "subnet-05166c5a650f638b9" -> null
  - ipv6_native = false -> null
  - map_customer_owned_ip_on_launch = false -> null
  - map_public_ip_on_launch = true -> null
  - owner_id = "740948698725" -> null
  - private_dns_hostname_type_on_launch = "ip-name" -> null
  - tags = {
    - "Name" = "vpc-public-subnet-3"
      } -> null
  - tags_all = {
    - "Name" = "vpc-public-subnet-3"
      } -> null
  - vpc_id = "vpc-0e2f029512e7fdfb6" -> null # (4 unchanged attributes hidden)
    }

# module.vpc.aws_vpc.main will be destroyed

- resource "aws_vpc" "main" {
  - arn = "arn:aws:ec2:us-west-2:740948698725:vpc/vpc-0e2f029512e7fdfb6" -> null
  - assign_generated_ipv6_cidr_block = false -> null
  - cidr_block = "10.0.0.0/16" -> null
  - default_network_acl_id = "acl-0f3f01251f4b73704" -> null
  - default_route_table_id = "rtb-0fb3a02b15ee28622" -> null
  - default_security_group_id = "sg-0316e5ce4972030ed" -> null
  - dhcp_options_id = "dopt-08897bc019727ec26" -> null
  - enable_dns_hostnames = true -> null
  - enable_dns_support = true -> null
  - enable_network_address_usage_metrics = false -> null
  - id = "vpc-0e2f029512e7fdfb6" -> null
  - instance_tenancy = "default" -> null
  - ipv6_netmask_length = 0 -> null
  - main_route_table_id = "rtb-0fb3a02b15ee28622" -> null
  - owner_id = "740948698725" -> null
  - tags = {
    - "Name" = "vpc-vpc"
      } -> null
  - tags_all = { - "Name" = "vpc-vpc"
    } -> null # (4 unchanged attributes hidden)
    }

Plan: 0 to add, 0 to change, 27 to destroy.

Changes to Outputs:

- dynamodb_table_name = "terraform-locks" -> null
- ecr_repository_url = "740948698725.dkr.ecr.us-west-2.amazonaws.com/lesson-5-ecr" -> null
- private_subnet_ids = [
  - "subnet-0cfa129338fb27e1a",
  - "subnet-0e15bab1300ef14b9",
  - "subnet-04f5032aefdc2768a",
    ] -> null
- public_subnet_ids = [
  - "subnet-0b16f520d238de4af",
  - "subnet-0d85a65f400c62eb7",
  - "subnet-05166c5a650f638b9",
    ] -> null
- s3_bucket_name = "terraform-state-inna-boiko-2026" -> null
- vpc_id = "vpc-0e2f029512e7fdfb6" -> null

Do you really want to destroy all resources?
Terraform will destroy all your managed infrastructure, as shown above.
There is no undo. Only 'yes' will be accepted to confirm.

Enter a value: yes

module.ecr.aws_ecr_lifecycle_policy.this: Destroying... [id=lesson-5-ecr]
module.vpc.aws_route_table_association.private[1]: Destroying... [id=rtbassoc-0a1e3e6f4c34aa53b]
module.vpc.aws_route_table_association.private[2]: Destroying... [id=rtbassoc-0667eb8e05c1305ed]
module.vpc.aws_route_table_association.public[2]: Destroying... [id=rtbassoc-0564e5ad9ea16ebbd]
module.vpc.aws_route_table_association.public[1]: Destroying... [id=rtbassoc-004e4a6fbae134dfd]
module.vpc.aws_route_table_association.private[0]: Destroying... [id=rtbassoc-003b9da4406ee0018]
module.vpc.aws_route_table_association.public[0]: Destroying... [id=rtbassoc-0150e8ae474afa452]
module.vpc.aws_route.private_nat: Destroying... [id=r-rtb-0161ff75ba4c5fa611080289494]
module.s3_backend.aws_s3_bucket_versioning.terraform_state_versioning: Destroying... [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_dynamodb_table.terraform_locks: Destroying... [id=terraform-locks]
module.s3_backend.aws_s3_bucket_versioning.terraform_state_versioning: Destruction complete after 1s
module.s3_backend.aws_s3_bucket_ownership_controls.terraform_state_ownership: Destroying... [id=terraform-state-inna-boiko-2026]
module.ecr.aws_ecr_lifecycle_policy.this: Destruction complete after 1s
module.ecr.aws_ecr_repository_policy.this: Destroying... [id=lesson-5-ecr]
module.ecr.aws_ecr_repository_policy.this: Destruction complete after 0s
module.vpc.aws_route.public_internet: Destroying... [id=r-rtb-0e9865c72165c4fcf1080289494]
module.vpc.aws_route_table_association.public[2]: Destruction complete after 1s
module.vpc.aws_route_table_association.public[1]: Destruction complete after 1s
module.vpc.aws_route_table_association.private[0]: Destruction complete after 1s
module.ecr.aws_ecr_repository.this: Destroying... [id=lesson-5-ecr]
module.vpc.aws_route_table_association.private[2]: Destruction complete after 1s
module.vpc.aws_route_table_association.public[0]: Destruction complete after 1s
module.vpc.aws_route_table_association.private[1]: Destruction complete after 1s
module.vpc.aws_subnet.private[2]: Destroying... [id=subnet-04f5032aefdc2768a]
module.vpc.aws_subnet.private[1]: Destroying... [id=subnet-0e15bab1300ef14b9]
module.vpc.aws_subnet.private[0]: Destroying... [id=subnet-0cfa129338fb27e1a]
module.s3_backend.aws_s3_bucket_ownership_controls.terraform_state_ownership: Destruction complete after 0s
module.s3_backend.aws_s3_bucket.terraform_state: Destroying... [id=terraform-state-inna-boiko-2026]
module.ecr.aws_ecr_repository.this: Destruction complete after 0s
module.vpc.aws_route.private_nat: Destruction complete after 1s
module.vpc.aws_nat_gateway.nat: Destroying... [id=nat-00b637f9aad6e0540]
module.vpc.aws_route_table.private: Destroying... [id=rtb-0161ff75ba4c5fa61]
module.vpc.aws_subnet.private[2]: Destruction complete after 1s
module.vpc.aws_subnet.private[1]: Destruction complete after 1s
module.vpc.aws_route.public_internet: Destruction complete after 1s
module.vpc.aws_route_table.public: Destroying... [id=rtb-0e9865c72165c4fcf]
module.vpc.aws_subnet.private[0]: Destruction complete after 1s
module.s3_backend.aws_s3_bucket.terraform_state: Destruction complete after 1s
module.vpc.aws_route_table.private: Destruction complete after 2s
module.vpc.aws_route_table.public: Destruction complete after 1s
module.s3_backend.aws_dynamodb_table.terraform_locks: Destruction complete after 8s
module.vpc.aws_nat_gateway.nat: Still destroying... [id=nat-00b637f9aad6e0540, 00m10s elapsed]
module.vpc.aws_nat_gateway.nat: Still destroying... [id=nat-00b637f9aad6e0540, 00m20s elapsed]
module.vpc.aws_nat_gateway.nat: Still destroying... [id=nat-00b637f9aad6e0540, 00m30s elapsed]
module.vpc.aws_nat_gateway.nat: Still destroying... [id=nat-00b637f9aad6e0540, 00m40s elapsed]
module.vpc.aws_nat_gateway.nat: Still destroying... [id=nat-00b637f9aad6e0540, 00m50s elapsed]
module.vpc.aws_nat_gateway.nat: Still destroying... [id=nat-00b637f9aad6e0540, 01m00s elapsed]
module.vpc.aws_nat_gateway.nat: Destruction complete after 1m2s
module.vpc.aws_subnet.public[1]: Destroying... [id=subnet-0d85a65f400c62eb7]
module.vpc.aws_subnet.public[0]: Destroying... [id=subnet-0b16f520d238de4af]
module.vpc.aws_eip.nat: Destroying... [id=eipalloc-08985452023a81519]
module.vpc.aws_subnet.public[2]: Destroying... [id=subnet-05166c5a650f638b9]
module.vpc.aws_subnet.public[0]: Destruction complete after 1s
module.vpc.aws_subnet.public[1]: Destruction complete after 1s
module.vpc.aws_subnet.public[2]: Destruction complete after 1s
module.vpc.aws_eip.nat: Destruction complete after 2s
module.vpc.aws_internet_gateway.igw: Destroying... [id=igw-02a6651c2df4b691d]
module.vpc.aws_internet_gateway.igw: Destruction complete after 1s
module.vpc.aws_vpc.main: Destroying... [id=vpc-0e2f029512e7fdfb6]
module.vpc.aws_vpc.main: Destruction complete after 1s

Destroy complete! Resources: 27 destroyed.
inna@iMac-di-Inna my-microservice-project %

```
