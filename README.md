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
  (versioning enabled, server-side encryption, all public access blocked) and a
  DynamoDB table used for state locking so the state cannot be modified by two
  runs at the same time. Outputs the bucket name and the DynamoDB table name.

- **vpc** — Creates a VPC (`10.0.0.0/16`) with 3 public and 3 private subnets
  across three availability zones, an Internet Gateway for the public subnets,
  and a NAT Gateway (with an Elastic IP) for outbound traffic from the private
  subnets. Route tables wire everything together. Outputs the VPC ID and subnet
  IDs.

- **ecr** — Creates an ECR repository with scan-on-push enabled, a repository
  access policy and a lifecycle policy that keeps only the last 10 images.
  Outputs the repository URL.

### Deployment

The backend has a chicken-and-egg problem: the S3 bucket and DynamoDB table that
hold the state must exist before the state can be moved into S3.

1. **Bootstrap** — comment out the `backend "s3"` block in
   [backend.tf](backend.tf), then run:

   ```bash
   terraform init
   terraform apply
   ```

   This creates the S3 bucket, DynamoDB table, VPC and ECR using a local state.

2. **Migrate state to S3** — uncomment the `backend "s3"` block and run:

   ```bash
   terraform init -migrate-state
   ```

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
  (`Apply complete! Resources: 27 added`) with the outputs.
- [terraform-destroy.md](terraform-destroy.md) — full `terraform destroy` log
  (`Destroy complete! Resources: 27 destroyed`).

| Resource | Screenshot |
|----------|------------|
| VPC (10.0.0.0/16, 6 subnets) | [VPC.png](public/images/VPC.png) |
| ECR repository | [ECR.png](public/images/ECR.png) |
| S3 state bucket | [S3.png](public/images/S3.png) |
