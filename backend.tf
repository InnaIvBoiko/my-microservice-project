# Remote backend configuration for storing Terraform state in S3,
# with state locking provided by the DynamoDB table.
#
# NOTE (bootstrap): the S3 bucket and DynamoDB table must already exist before
# this backend can be used. On a brand-new environment, comment this block out,
# run "terraform apply" once to create them, then uncomment it and run
# "terraform init -migrate-state" to move the state into S3.
terraform {
  backend "s3" {
    bucket         = "terraform-state-inna-boiko-2026"
    key            = "lesson-7/terraform.tfstate"
    region         = "us-west-2"
    use_lockfile   = true
    encrypt        = true
  }
}
