# Terraform destroy — output (lesson-5)

**Command:** `terraform destroy`
**Region:** us-west-2 — **Account:** 740948698725

**Result:** `Destroy complete! Resources: 30 destroyed.`

All resources were removed after testing, to avoid further AWS charges.

---

```
macbookpro@MacBook-Pro-MacBook my-microservice-project % terraform destroy -auto-approve

module.ecr.data.aws_caller_identity.current: Reading...
module.vpc.aws_vpc.main: Refreshing state... [id=vpc-0eb3864256a8e4852]
module.ecr.aws_ecr_repository.this: Refreshing state... [id=lesson-5-ecr]
module.s3_backend.aws_dynamodb_table.terraform_locks: Refreshing state... [id=terraform-locks]
module.s3_backend.aws_s3_bucket.terraform_state: Refreshing state... [id=terraform-state-inna-boiko-2026]
module.ecr.data.aws_caller_identity.current: Read complete after 0s [id=740948698725]
module.ecr.aws_ecr_lifecycle_policy.this: Refreshing state... [id=lesson-5-ecr]
module.ecr.aws_ecr_repository_policy.this: Refreshing state... [id=lesson-5-ecr]
module.vpc.aws_route_table.public: Refreshing state... [id=rtb-0730c46165d367f1e]
module.vpc.aws_route_table.private: Refreshing state... [id=rtb-0fc00ab524fa35083]
module.vpc.aws_internet_gateway.igw: Refreshing state... [id=igw-0089292c1c690350f]
module.vpc.aws_subnet.public[0]: Refreshing state... [id=subnet-033597d31946a5dcc]
module.vpc.aws_subnet.public[1]: Refreshing state... [id=subnet-08abf4d42cff96705]
module.vpc.aws_subnet.public[2]: Refreshing state... [id=subnet-0fac1e87f51f879dc]
module.vpc.aws_subnet.private[0]: Refreshing state... [id=subnet-0d5af43481cc9a447]
module.vpc.aws_subnet.private[1]: Refreshing state... [id=subnet-0d813d444e277fed6]
module.vpc.aws_subnet.private[2]: Refreshing state... [id=subnet-0fab243b66f34993e]
module.vpc.aws_eip.nat: Refreshing state... [id=eipalloc-07fea6120191e474b]
module.vpc.aws_route.public_internet: Refreshing state... [id=r-rtb-0730c46165d367f1e1080289494]
module.s3_backend.aws_s3_bucket_ownership_controls.terraform_state_ownership: Refreshing state... [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_versioning.terraform_state_versioning: Refreshing state... [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_server_side_encryption_configuration.terraform_state_encryption: Refreshing state... [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_public_access_block.terraform_state_public_access: Refreshing state... [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_lifecycle_configuration.terraform_state_lifecycle: Refreshing state... [id=terraform-state-inna-boiko-2026]
module.vpc.aws_route_table_association.private[0]: Refreshing state... [id=rtbassoc-03c0a9cb1572d0bec]
module.vpc.aws_route_table_association.private[1]: Refreshing state... [id=rtbassoc-0a6b0bf4a86ac4e27]
module.vpc.aws_route_table_association.private[2]: Refreshing state... [id=rtbassoc-01959091baea86188]
module.vpc.aws_route_table_association.public[0]: Refreshing state... [id=rtbassoc-0a889d96887e91468]
module.vpc.aws_route_table_association.public[1]: Refreshing state... [id=rtbassoc-0adcd278b62fc2cb2]
module.vpc.aws_route_table_association.public[2]: Refreshing state... [id=rtbassoc-03817c446836dd366]
module.vpc.aws_nat_gateway.nat: Refreshing state... [id=nat-0468f37f972aba3da]
module.vpc.aws_route.private_nat: Refreshing state... [id=r-rtb-0fc00ab524fa350831080289494]

Plan: 0 to add, 0 to change, 30 to destroy.

Changes to Outputs:
  - dynamodb_table_name = "terraform-locks" -> null
  - ecr_repository_url  = "740948698725.dkr.ecr.us-west-2.amazonaws.com/lesson-5-ecr" -> null
  - private_subnet_ids  = ["subnet-0d5af43481cc9a447", "subnet-0d813d444e277fed6", "subnet-0fab243b66f34993e"] -> null
  - public_subnet_ids   = ["subnet-033597d31946a5dcc", "subnet-08abf4d42cff96705", "subnet-0fac1e87f51f879dc"] -> null
  - s3_bucket_name      = "terraform-state-inna-boiko-2026" -> null
  - vpc_id              = "vpc-0eb3864256a8e4852" -> null

module.ecr.aws_ecr_lifecycle_policy.this: Destroying... [id=lesson-5-ecr]
module.vpc.aws_route_table_association.private[0]: Destroying... [id=rtbassoc-03c0a9cb1572d0bec]
module.vpc.aws_route_table_association.private[1]: Destroying... [id=rtbassoc-0a6b0bf4a86ac4e27]
module.vpc.aws_route_table_association.private[2]: Destroying... [id=rtbassoc-01959091baea86188]
module.vpc.aws_route_table_association.public[0]: Destroying... [id=rtbassoc-0a889d96887e91468]
module.vpc.aws_route_table_association.public[1]: Destroying... [id=rtbassoc-0adcd278b62fc2cb2]
module.vpc.aws_route_table_association.public[2]: Destroying... [id=rtbassoc-03817c446836dd366]
module.vpc.aws_route.private_nat: Destroying... [id=r-rtb-0fc00ab524fa350831080289494]
module.s3_backend.aws_s3_bucket_lifecycle_configuration.terraform_state_lifecycle: Destroying... [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_versioning.terraform_state_versioning: Destroying... [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_dynamodb_table.terraform_locks: Destroying... [id=terraform-locks]
module.ecr.aws_ecr_lifecycle_policy.this: Destruction complete after 0s [id=lesson-5-ecr]
module.ecr.aws_ecr_repository_policy.this: Destroying... [id=lesson-5-ecr]
module.s3_backend.aws_s3_bucket_versioning.terraform_state_versioning: Destruction complete after 1s [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_lifecycle_configuration.terraform_state_lifecycle: Destruction complete after 1s [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_ownership_controls.terraform_state_ownership: Destroying... [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_server_side_encryption_configuration.terraform_state_encryption: Destroying... [id=terraform-state-inna-boiko-2026]
module.vpc.aws_route_table_association.private[0]: Destruction complete after 1s [id=rtbassoc-03c0a9cb1572d0bec]
module.vpc.aws_route_table_association.private[1]: Destruction complete after 1s [id=rtbassoc-0a6b0bf4a86ac4e27]
module.vpc.aws_route_table_association.private[2]: Destruction complete after 1s [id=rtbassoc-01959091baea86188]
module.vpc.aws_route_table_association.public[0]: Destruction complete after 1s [id=rtbassoc-0a889d96887e91468]
module.vpc.aws_route_table_association.public[1]: Destruction complete after 1s [id=rtbassoc-0adcd278b62fc2cb2]
module.vpc.aws_route_table_association.public[2]: Destruction complete after 1s [id=rtbassoc-03817c446836dd366]
module.vpc.aws_subnet.private[0]: Destroying... [id=subnet-0d5af43481cc9a447]
module.vpc.aws_subnet.private[1]: Destroying... [id=subnet-0d813d444e277fed6]
module.vpc.aws_subnet.private[2]: Destroying... [id=subnet-0fab243b66f34993e]
module.ecr.aws_ecr_repository_policy.this: Destruction complete after 1s [id=lesson-5-ecr]
module.ecr.aws_ecr_repository.this: Destroying... [id=lesson-5-ecr]
module.vpc.aws_route.private_nat: Destruction complete after 1s [id=r-rtb-0fc00ab524fa350831080289494]
module.vpc.aws_nat_gateway.nat: Destroying... [id=nat-0468f37f972aba3da]
module.vpc.aws_route.public_internet: Destroying... [id=r-rtb-0730c46165d367f1e1080289494]
module.s3_backend.aws_s3_bucket_ownership_controls.terraform_state_ownership: Destruction complete after 0s [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_server_side_encryption_configuration.terraform_state_encryption: Destruction complete after 0s [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_public_access_block.terraform_state_public_access: Destroying... [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket_public_access_block.terraform_state_public_access: Destruction complete after 0s [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket.terraform_state: Destroying... [id=terraform-state-inna-boiko-2026]
module.s3_backend.aws_s3_bucket.terraform_state: Destruction complete after 1s [id=terraform-state-inna-boiko-2026]
module.vpc.aws_route.public_internet: Destruction complete after 1s [id=r-rtb-0730c46165d367f1e1080289494]
module.vpc.aws_subnet.private[0]: Destruction complete after 1s [id=subnet-0d5af43481cc9a447]
module.vpc.aws_subnet.private[1]: Destruction complete after 1s [id=subnet-0d813d444e277fed6]
module.vpc.aws_subnet.private[2]: Destruction complete after 1s [id=subnet-0fab243b66f34993e]
module.vpc.aws_route_table.private: Destroying... [id=rtb-0fc00ab524fa35083]
module.ecr.aws_ecr_repository.this: Destruction complete after 1s [id=lesson-5-ecr]
module.vpc.aws_route_table.private: Destruction complete after 1s [id=rtb-0fc00ab524fa35083]
module.s3_backend.aws_dynamodb_table.terraform_locks: Destruction complete after 9s [id=terraform-locks]
module.vpc.aws_nat_gateway.nat: Still destroying... [id=nat-0468f37f972aba3da, 00m10s elapsed]
module.vpc.aws_nat_gateway.nat: Still destroying... [id=nat-0468f37f972aba3da, 00m20s elapsed]
module.vpc.aws_nat_gateway.nat: Still destroying... [id=nat-0468f37f972aba3da, 00m30s elapsed]
module.vpc.aws_nat_gateway.nat: Still destroying... [id=nat-0468f37f972aba3da, 00m40s elapsed]
module.vpc.aws_nat_gateway.nat: Still destroying... [id=nat-0468f37f972aba3da, 00m50s elapsed]
module.vpc.aws_nat_gateway.nat: Still destroying... [id=nat-0468f37f972aba3da, 01m00s elapsed]
module.vpc.aws_nat_gateway.nat: Destruction complete after 1m2s [id=nat-0468f37f972aba3da]
module.vpc.aws_subnet.public[0]: Destroying... [id=subnet-033597d31946a5dcc]
module.vpc.aws_subnet.public[1]: Destroying... [id=subnet-08abf4d42cff96705]
module.vpc.aws_subnet.public[2]: Destroying... [id=subnet-0fac1e87f51f879dc]
module.vpc.aws_eip.nat: Destroying... [id=eipalloc-07fea6120191e474b]
module.vpc.aws_subnet.public[0]: Destruction complete after 1s [id=subnet-033597d31946a5dcc]
module.vpc.aws_subnet.public[1]: Destruction complete after 1s [id=subnet-08abf4d42cff96705]
module.vpc.aws_subnet.public[2]: Destruction complete after 1s [id=subnet-0fac1e87f51f879dc]
module.vpc.aws_eip.nat: Destruction complete after 2s [id=eipalloc-07fea6120191e474b]
module.vpc.aws_internet_gateway.igw: Destroying... [id=igw-0089292c1c690350f]
module.vpc.aws_route_table.public: Destroying... [id=rtb-0730c46165d367f1e]
module.vpc.aws_route_table.public: Destruction complete after 1s [id=rtb-0730c46165d367f1e]
module.vpc.aws_internet_gateway.igw: Destruction complete after 1s [id=igw-0089292c1c690350f]
module.vpc.aws_vpc.main: Destroying... [id=vpc-0eb3864256a8e4852]
module.vpc.aws_vpc.main: Destruction complete after 1s [id=vpc-0eb3864256a8e4852]

Destroy complete! Resources: 30 destroyed.
```
