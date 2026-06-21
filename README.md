# My own microservice project

This is a repository for a learning project within the "DevOps CI/CD" course.

## Lesson 5 — Terraform: modular AWS infrastructure

The infrastructure is described with Terraform modules and consists of three
parts: a state backend (S3 + DynamoDB), networking (VPC) and an image
registry (ECR).

### Project structure

```
lesson-5/
├── main.tf                  # Wires modules together, provider, common tags
├── backend.tf               # Remote state backend (S3 + DynamoDB)
├── outputs.tf               # Aggregated outputs from all modules
│
├── modules/
│   ├── s3-backend/          # S3 bucket + DynamoDB for state
│   │   ├── s3.tf
│   │   ├── dynamodb.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── vpc/                 # VPC, subnets, Internet/NAT gateways, routing
│   │   ├── vpc.tf
│   │   ├── routes.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── ecr/                 # ECR repository
│       ├── ecr.tf
│       ├── variables.tf
│       └── outputs.tf
│
└── README.md
```

### Modules

- **s3-backend** — Creates the S3 bucket that stores the Terraform state
  (versioning enabled, AES-256 server-side encryption, all public access
  blocked, lifecycle policy to expire old versions after 90 days) and a
  DynamoDB table used for state locking so concurrent runs cannot corrupt the
  state. Outputs the bucket name and the DynamoDB table name.

- **vpc** — Creates a VPC (`10.0.0.0/16`) with 3 public and 3 private subnets
  across three availability zones, an Internet Gateway for the public subnets,
  and a NAT Gateway (with an Elastic IP) for outbound traffic from the private
  subnets. Route tables wire everything together. Outputs the VPC ID and subnet
  IDs.

- **ecr** — Creates an ECR repository with scan-on-push enabled, AES-256
  encryption at rest, a repository access policy scoped to the current AWS
  account only (via `aws_caller_identity`), and a lifecycle policy that keeps
  only the last 10 images. Outputs the repository URL.

### Deployment

The backend has a chicken-and-egg problem: the S3 bucket must exist before it
can be used as a backend. The one-time bootstrap procedure resolves this.

1. **Bootstrap** — temporarily disable the remote backend and create the
   infrastructure with a local state:

   ```bash
   terraform init -reconfigure -backend=false
   terraform apply
   ```

   This creates the S3 bucket, DynamoDB table, VPC and ECR.

2. **Migrate state to S3** — re-enable the backend and move the local state
   into the newly created bucket:

   ```bash
   terraform init -migrate-state
   ```

   From this point on, `terraform plan` / `terraform apply` work normally with
   no further changes to `backend.tf`.

### State locking — DynamoDB vs native S3 locking

The current setup uses `dynamodb_table = "terraform-locks"` in `backend.tf`,
which triggers a deprecation warning from the AWS provider v5. There are two
paths forward:

**Option A — Keep DynamoDB (current approach)**
The `dynamodb_table` parameter still works and is the approach required by this
course. A DynamoDB table is created by the `s3-backend` module and referenced
in the backend config. The deprecation warning is cosmetic and does not affect
functionality.

**Option B — Switch to native S3 locking (Terraform ≥ 1.10)**
Replace `dynamodb_table` with `use_lockfile = true` in `backend.tf`:

```hcl
terraform {
  backend "s3" {
    bucket       = "terraform-state-inna-boiko-2026"
    key          = "lesson-5/terraform.tfstate"
    region       = "us-west-2"
    use_lockfile = true   # replaces dynamodb_table
    encrypt      = true
  }
}
```

With this option the lock file is stored directly in S3 alongside the state
(as `terraform.tfstate.tflock`), and the DynamoDB table can be removed from
the module entirely. This eliminates the warning and reduces the number of
managed resources by one.

### Commands

```bash
terraform init      # Initialize the working directory and download providers
terraform plan      # Preview the changes
terraform apply     # Create / update the infrastructure
terraform destroy   # Tear down all managed resources
```

### Main variables

| Variable       | Description              | Default        |
|----------------|--------------------------|----------------|
| `aws_region`   | AWS region               | `us-west-2`    |
| `project_name` | Project name / prefix    | `lesson-5`     |

### Proof of deployment

The infrastructure was deployed to AWS (region `us-west-2`) and then destroyed to
avoid charges. Logs and screenshots are included as proof:

- [terraform-output.md](terraform-output.md) — full `terraform apply` log
  (`Apply complete! Resources: 30 added`) with the outputs.
- [terraform-destroy.md](terraform-destroy.md) — full `terraform destroy` log
  (`Destroy complete! Resources: 30 destroyed`).

| Resource | Screenshot |
|----------|------------|
| VPC (10.0.0.0/16, 6 subnets) | [VPC.png](public/images/VPC.png) |
| ECR repository | [ECR.png](public/images/ECR.png) |
| S3 state bucket | [S3.png](public/images/S3.png) |
