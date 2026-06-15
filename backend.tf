# Remote backend configuration for storing Terraform state.
#
# IMPORTANT (bootstrap): the S3 bucket and DynamoDB table that hold the state
# must be created first using the s3-backend module with a local state. So on
# the very first run this block must stay commented out:
#   1. terraform init && terraform apply   (creates the bucket and table locally)
#   2. uncomment the block below
#   3. terraform init -migrate-state        (moves the state into S3)

terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-001001"
    key            = "lesson-5/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
