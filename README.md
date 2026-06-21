# My Microservice Project

This is a repository for a learning project within the "DevOps CI/CD" course.

---

## Lesson 6 — Terraform + EKS

Extends the Lesson 5 infrastructure by adding an **EKS (Elastic Kubernetes Service)** module — a managed Kubernetes cluster with an EC2 node group.

### Project structure

```
lesson-6/
├── main.tf                  # Wires all modules together, provider, common tags
├── backend.tf               # Remote state backend (S3 + native locking)
├── outputs.tf               # Aggregated outputs from all modules
│
├── modules/
│   ├── s3-backend/          # S3 bucket + DynamoDB for Terraform state
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
│   ├── ecr/                 # ECR repository for Docker images
│   │   ├── ecr.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── eks/                 # EKS cluster + worker node group
│       ├── eks.tf           # IAM role for the cluster + aws_eks_cluster
│       ├── node.tf          # IAM role for nodes + aws_eks_node_group
│       ├── variables.tf
│       └── outputs.tf
│
└── README.md
```

### Modules

- **s3-backend** — Creates the S3 bucket (versioning + `force_destroy`) that stores
  the Terraform state and a DynamoDB table for state locking. Outputs the bucket
  name and table name.

- **vpc** — Creates a VPC (`10.0.0.0/16`) with 3 public and 3 private subnets across
  three availability zones, an Internet Gateway, a NAT Gateway (with an Elastic IP)
  for outbound traffic from private subnets, and the corresponding route tables.

- **ecr** — Creates an ECR repository with scan-on-push enabled, a repository access
  policy, and a lifecycle policy that retains only the last 10 images.

- **eks** — Creates two IAM roles (one for the EKS control plane, one for EC2 worker
  nodes), attaches the required AWS managed policies to each, creates the EKS cluster,
  and provisions a managed node group (`ON_DEMAND`, configurable instance type and
  scaling parameters).

### EKS IAM design

| Role | Used by | Policies attached |
|------|---------|-------------------|
| `<cluster>-eks-cluster` | EKS control plane | `AmazonEKSClusterPolicy` |
| `<cluster>-eks-nodes` | EC2 worker nodes | `AmazonEKSWorkerNodePolicy`, `AmazonEKS_CNI_Policy`, `AmazonEC2ContainerRegistryReadOnly` |

### Deployment

#### Bootstrap (first run)

The S3 bucket must exist before Terraform can use it as a backend.

1. Comment out the `backend "s3"` block in [backend.tf](backend.tf).
2. Run:
   ```bash
   terraform init
   terraform apply -target=module.s3_backend
   ```
3. Uncomment the `backend "s3"` block and migrate state to S3:
   ```bash
   terraform init -migrate-state
   ```
4. Deploy the remaining infrastructure:
   ```bash
   terraform apply
   ```

> **Note:** EKS cluster creation takes ~10 minutes; the node group takes an additional
> 10–15 minutes.

#### Teardown

Because the S3 bucket uses versioning, destroying it requires migrating state back to
local first (otherwise Terraform cannot delete the very bucket that holds its state).

```bash
# 1. Pull remote state to local
#    (comment out backend "s3" in backend.tf first)
terraform init -migrate-state

# 2. Destroy everything
terraform destroy
```

The `force_destroy = true` flag on the S3 bucket ensures all object versions are
removed before the bucket is deleted.

### Commands

```bash
terraform init               # Initialise the working directory and download providers
terraform validate           # Check configuration syntax
terraform plan               # Preview what will be created / changed / destroyed
terraform apply              # Apply the plan
terraform apply -target=X    # Apply only module X (useful for bootstrap)
terraform destroy            # Tear down all managed resources
terraform init -migrate-state  # Move state between backends
```

### Key variables

| Variable        | Module | Description                     | Default              |
|-----------------|--------|---------------------------------|----------------------|
| `aws_region`    | root   | AWS region                      | `us-west-2`          |
| `project_name`  | root   | Project name / tag prefix       | `lesson-5`           |
| `cluster_name`  | eks    | EKS cluster name                | `example-eks-cluster`|
| `instance_type` | eks    | EC2 instance type for nodes     | `t3.medium`          |
| `desired_size`  | eks    | Desired number of worker nodes  | `2`                  |
| `max_size`      | eks    | Maximum number of worker nodes  | `3`                  |
| `min_size`      | eks    | Minimum number of worker nodes  | `1`                  |

---

## Lesson 5 — Terraform: modular AWS infrastructure

The infrastructure is described with Terraform modules and consists of three
parts: a state backend (S3 + DynamoDB), networking (VPC), and an image
registry (ECR).

### Proof of deployment

The infrastructure was deployed to AWS (region `us-west-2`) and then destroyed to
avoid charges.

- [terraform-output.md](terraform-output.md) — full `terraform apply` log
- [terraform-destroy.md](terraform-destroy.md) — full `terraform destroy` log

| Resource | Screenshot |
|----------|------------|
| VPC (10.0.0.0/16, 6 subnets) | [VPC.png](public/images/VPC.png) |
| ECR repository | [ECR.png](public/images/ECR.png) |
| S3 state bucket | [S3.png](public/images/S3.png) |
