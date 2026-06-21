# Terraform destroy — output (lesson-5)

**Command:** `terraform destroy`
**Region:** us-west-2 — **Account:** 740948698725

**Result:** `Destroy complete! Resources: 30 destroyed.`

All resources were removed after testing, to avoid further AWS charges.

---

```text
macbookpro@MacBook-Pro-MacBook my-microservice-project % terraform destroy

module.ecr.data.aws_caller_identity.current: Reading...
module.vpc.aws_vpc.main: Refreshing state... [id=vpc-0a6aa1888d78815ac]
module.ecr.aws_ecr_repository.this: Refreshing state... [id=lesson-5-ecr]
module.s3_backend.aws_dynamodb_table.terraform_locks: Refreshing state... [id=terraform-locks]
module.s3_backend.aws_s3_bucket.terraform_state: Refreshing state... [id=terraform-state-inna-boiko-2026]
module.ecr.data.aws_caller_identity.current: Read complete after 0s [id=740948698725]
module.ecr.aws_ecr_lifecycle_policy.this: Refreshing state... [id=lesson-5-ecr]
module.ecr.aws_ecr_repository_policy.this: Refreshing state... [id=lesson-5-ecr]
module.vpc.aws_route_table.public: Refreshing state... [id=rtb-009ff42d4b3270c24]
module.vpc.aws_route_table.private: Refreshing state... [id=rtb-0854809864028ddc1]
module.vpc.aws_internet_gateway.igw: Refreshing state... [id=igw-0ad5407c2e28c0dbf]
module.vpc.aws_subnet.public[0]: Refreshing state... [id=subnet-08df0b204366c91ac]
module.vpc.aws_subnet.public[1]: Refreshing state... [id=subnet-077e24fd3f2bba393]
module.vpc.aws_subnet.public[2]: Refreshing state... [id=subnet-0971f9c832c85f6c8]
module.vpc.aws_subnet.private[0]: Refreshing state... [id=subnet-052dd6d5d0ca34e4a]
module.vpc.aws_subnet.private[1]: Refreshing state... [id=subnet-0c0cf6218c85940ba]
module.vpc.aws_subnet.private[2]: Refreshing state... [id=subnet-0cc9c8b31e3d9729b]
module.vpc.aws_eip.nat: Refreshing state... [id=eipalloc-0b5982dcd14b1148a]
module.vpc.aws_route.public_internet: Refreshing state... [id=r-rtb-009ff42d4b3270c241080289494]
module.vpc.aws_route_table_association.public[0]: Refreshing state... [id=rtbassoc-087ef6c2ae8096cf6]
module.vpc.aws_route_table_association.public[1]: Refreshing state... [id=rtbassoc-01cf64e27c2bcd1a6]
module.vpc.aws_route_table_association.public[2]: Refreshing state... [id=rtbassoc-0e1d7c90710c42090]
module.vpc.aws_route_table_association.private[0]: Refreshing state... [id=rtbassoc-01dba1d314e6963de]
module.vpc.aws_route_table_association.private[1]: Refreshing state... [id=rtbassoc-0562b91caec183722]
module.vpc.aws_route_table_association.private[2]: Refreshing state... [id=rtbassoc-05862c5bf10b8941a]
module.s3_backend.aws_s3_bucket_public_access_block.terraform_state_public_access: Refreshing state... [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_server_side_encryption_configuration.terraform_state_encryption: Refreshing state... [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_ownership_controls.terraform_state_ownership: Refreshing state... [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_versioning.terraform_state_versioning: Refreshing state... [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_lifecycle_configuration.terraform_state_lifecycle: Refreshing state... [id=terraform-state-inna-boiko-2026]
module.vpc.aws_nat_gateway.nat: Refreshing state... [id=nat-06326ee6ccbfd6826]
module.vpc.aws_route.private_nat: Refreshing state... [id=r-rtb-0854809864028ddc11080289494]

Plan: 0 to add, 0 to change, 30 to destroy.

Changes to Outputs:
  - dynamodb_table_name = "terraform-locks" -> null
  - ecr_repository_url  = "740948698725.dkr.ecr.us-west-2.amazonaws.com/lesson-5-ecr" -> null
  - private_subnet_ids  = ["subnet-052dd6d5d0ca34e4a", "subnet-0c0cf6218c85940ba", "subnet-0cc9c8b31e3d9729b"] -> null
  - public_subnet_ids   = ["subnet-08df0b204366c91ac", "subnet-077e24fd3f2bba393", "subnet-0971f9c832c85f6c8"] -> null
  - s3_bucket_name      = "terraform-state-inna-boiko-2026" -> null
  - vpc_id              = "vpc-0a6aa1888d78815ac" -> null

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

module.ecr.aws_ecr_lifecycle_policy.this: Destroying... [id=lesson-5-ecr]
module.vpc.aws_route.public_internet: Destroying... [id=r-rtb-009ff42d4b3270c241080289494]
module.s3_backend.aws_s3_bucket_public_access_block.terraform_state_public_access: Destroying... [id=terraform-state-inna-boiko-2026]
module.vpc.aws_route_table_association.private[0]: Destroying... [id=rtbassoc-01dba1d314e6963de]
module.vpc.aws_route_table_association.private[1]: Destroying... [id=rtbassoc-0562b91caec183722]
module.vpc.aws_route_table_association.public[0]: Destroying... [id=rtbassoc-087ef6c2ae8096cf6]
module.s3_backend.aws_s3_bucket_server_side_encryption_configuration.terraform_state_encryption: Destroying... [id=terraform-state-inna-boiko-2026]
module.vpc.aws_route_table_association.public[2]: Destroying... [id=rtbassoc-0e1d7c90710c42090]
module.ecr.aws_ecr_repository_policy.this: Destroying... [id=lesson-5-ecr]
module.vpc.aws_route.private_nat: Destroying... [id=r-rtb-0854809864028ddc11080289494]
module.ecr.aws_ecr_repository_policy.this: Destruction complete after 1s
module.s3_backend.aws_dynamodb_table.terraform_locks: Destroying... [id=terraform-locks]
module.ecr.aws_ecr_lifecycle_policy.this: Destruction complete after 1s
module.s3_backend.aws_s3_bucket_ownership_controls.terraform_state_ownership: Destroying... [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_public_access_block.terraform_state_public_access: Destruction complete after 1s
module.s3_backend.aws_s3_bucket_versioning.terraform_state_versioning: Destroying... [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_server_side_encryption_configuration.terraform_state_encryption: Destruction complete after 1s
module.vpc.aws_route_table_association.private[2]: Destroying... [id=rtbassoc-05862c5bf10b8941a]
module.vpc.aws_route_table_association.public[0]: Destruction complete after 1s
module.vpc.aws_route_table_association.public[1]: Destroying... [id=rtbassoc-01cf64e27c2bcd1a6]
module.vpc.aws_route_table_association.private[1]: Destruction complete after 1s
module.s3_backend.aws_s3_bucket_lifecycle_configuration.terraform_state_lifecycle: Destroying... [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_versioning.terraform_state_versioning: Destruction complete after 0s
module.ecr.aws_ecr_repository.this: Destroying... [id=lesson-5-ecr]
module.vpc.aws_route_table_association.private[0]: Destruction complete after 1s
module.s3_backend.aws_s3_bucket_ownership_controls.terraform_state_ownership: Destruction complete after 1s
module.vpc.aws_route_table_association.public[2]: Destruction complete after 2s
module.vpc.aws_route_table_association.private[2]: Destruction complete after 1s
module.vpc.aws_subnet.private[2]: Destroying... [id=subnet-0cc9c8b31e3d9729b]
module.vpc.aws_subnet.private[0]: Destroying... [id=subnet-052dd6d5d0ca34e4a]
module.vpc.aws_subnet.private[1]: Destroying... [id=subnet-0c0cf6218c85940ba]
module.vpc.aws_route.private_nat: Destruction complete after 2s
module.vpc.aws_nat_gateway.nat: Destroying... [id=nat-06326ee6ccbfd6826]
module.vpc.aws_route_table.private: Destroying... [id=rtb-0854809864028ddc1]
module.vpc.aws_route.public_internet: Destruction complete after 2s
module.ecr.aws_ecr_repository.this: Destruction complete after 1s
module.s3_backend.aws_s3_bucket_lifecycle_configuration.terraform_state_lifecycle: Destruction complete after 1s
module.vpc.aws_route_table_association.public[1]: Destruction complete after 1s
module.vpc.aws_route_table.public: Destroying... [id=rtb-009ff42d4b3270c24]
module.s3_backend.aws_s3_bucket.terraform_state: Destroying... [id=terraform-state-inna-boiko-2026]
module.vpc.aws_subnet.private[0]: Destruction complete after 1s
module.vpc.aws_subnet.private[2]: Destruction complete after 1s
module.vpc.aws_subnet.private[1]: Destruction complete after 1s
module.vpc.aws_route_table.private: Destruction complete after 1s
module.vpc.aws_route_table.public: Destruction complete after 1s
module.s3_backend.aws_dynamodb_table.terraform_locks: Destruction complete after 8s
module.vpc.aws_nat_gateway.nat: Still destroying... [id=nat-06326ee6ccbfd6826, 00m10s elapsed]
module.vpc.aws_nat_gateway.nat: Still destroying... [id=nat-06326ee6ccbfd6826, 00m20s elapsed]
module.vpc.aws_nat_gateway.nat: Still destroying... [id=nat-06326ee6ccbfd6826, 00m30s elapsed]
module.vpc.aws_nat_gateway.nat: Still destroying... [id=nat-06326ee6ccbfd6826, 00m40s elapsed]
module.vpc.aws_nat_gateway.nat: Still destroying... [id=nat-06326ee6ccbfd6826, 00m50s elapsed]
module.vpc.aws_nat_gateway.nat: Still destroying... [id=nat-06326ee6ccbfd6826, 01m00s elapsed]
module.vpc.aws_nat_gateway.nat: Destruction complete after 1m2s
module.vpc.aws_subnet.public[2]: Destroying... [id=subnet-0971f9c832c85f6c8]
module.vpc.aws_subnet.public[1]: Destroying... [id=subnet-077e24fd3f2bba393]
module.vpc.aws_subnet.public[0]: Destroying... [id=subnet-08df0b204366c91ac]
module.vpc.aws_eip.nat: Destroying... [id=eipalloc-0b5982dcd14b1148a]
module.vpc.aws_subnet.public[1]: Destruction complete after 0s
module.vpc.aws_subnet.public[0]: Destruction complete after 0s
module.vpc.aws_subnet.public[2]: Destruction complete after 0s
module.vpc.aws_eip.nat: Destruction complete after 1s
module.vpc.aws_internet_gateway.igw: Destroying... [id=igw-0ad5407c2e28c0dbf]
module.vpc.aws_internet_gateway.igw: Destruction complete after 1s
module.vpc.aws_vpc.main: Destroying... [id=vpc-0a6aa1888d78815ac]
module.vpc.aws_vpc.main: Destruction complete after 1s
module.s3_backend.aws_s3_bucket.terraform_state: Destruction complete after 1s

Destroy complete! Resources: 30 destroyed.
```
