# My Microservice Project — Lesson 8-9: CI/CD with Jenkins + ArgoCD

Full CI/CD pipeline on AWS EKS: Jenkins builds and pushes a Docker image to ECR, updates the Helm chart tag in Git, and ArgoCD automatically deploys the new version to Kubernetes.

---

## CI/CD Flow

```
Developer
    │
    │  git push (lesson-8-9)
    ▼
GitHub (my-microservice-project)
    │
    │  webhook / poll SCM
    ▼
Jenkins (running inside EKS)
    │
    ├─► [Stage 1] Build & Push Docker Image
    │       Kaniko reads docker/django/Dockerfile
    │       Pushes image to Amazon ECR
    │       Tags: v1.0.{BUILD_NUMBER}  +  latest
    │
    └─► [Stage 2] Update Helm Chart Tag
            Clones repo, checks out lesson-8-9
            Updates charts/django-app/values.yaml  →  tag: v1.0.N
            git commit + git push  →  GitHub
                │
                │  ArgoCD detects change (autoSync)
                ▼
            Kubernetes (EKS)
                Rolling update of Django pods
                ✅  New version is live
```

---

## Project Structure

```
├── Jenkinsfile              # CI/CD pipeline (Build → Push → Update tag)
├── main.tf                  # Root: providers + all modules
├── backend.tf               # Remote state (S3 + DynamoDB)
├── variables.tf             # All input variables
├── outputs.tf               # Aggregated outputs
├── terraform.tfvars         # Your secrets (gitignored)
├── terraform.tfvars.example # Template — copy and fill in
│
├── modules/
│   ├── s3-backend/          # S3 bucket + DynamoDB for Terraform state
│   ├── vpc/                 # VPC, subnets, IGW, NAT, route tables
│   ├── ecr/                 # ECR repository for Docker images
│   ├── eks/                 # EKS cluster + node group + EBS CSI Driver
│   ├── jenkins/             # Jenkins via Helm (IRSA, JCasC, Kaniko SA)
│   ├── argo_cd/             # ArgoCD via Helm + Application CRDs
│   │   └── charts/          # Local Helm chart that creates ArgoCD Applications
│   └── ingress/             # ALB Ingress Controller + ACM cert + HTTPS
│
├── charts/
│   └── django-app/          # Helm chart for the Django application
│       ├── Chart.yaml
│       ├── values.yaml      # image.tag updated automatically by Jenkins
│       └── templates/
│           ├── deployment.yaml
│           ├── service.yaml
│           ├── configmap.yaml
│           ├── secret.yaml
│           └── hpa.yaml
│
└── docker/
    └── django/              # Django application source + Dockerfile
```

---

## Infrastructure Components

| Module | What it creates |
|---|---|
| **s3-backend** | S3 bucket (versioned, encrypted) + DynamoDB table for state locking |
| **vpc** | VPC `10.0.0.0/16`, 3 public + 3 private subnets, IGW, NAT Gateway |
| **ecr** | ECR repository with scan-on-push, lifecycle rule (keep last 10 images) |
| **eks** | EKS control plane + managed node group (`t3.small`) + EBS CSI Driver (IRSA) |
| **jenkins** | Jenkins `5.8.27` via Helm; Kubernetes namespace + admin Secret + GitHub Secret + IRSA role for Kaniko → ECR; JCasC auto-creates credentials and seed job |
| **argo_cd** | ArgoCD `7.4.4` via Helm; repo credentials via labeled Kubernetes Secret; ArgoCD Application CRDs via local chart |
| **ingress** | AWS Load Balancer Controller + ACM wildcard cert + Route53 DNS validation + Kubernetes Ingress for Jenkins and ArgoCD (HTTPS, HTTP→HTTPS redirect) |

---

## How to Apply Terraform

### Prerequisites

- AWS CLI configured (`aws configure`)
- Terraform ≥ 1.5.0
- A domain hosted in Route53 (for HTTPS — if skipping ingress, set `domain_name = ""` and remove the ingress module from `main.tf`)
- A GitHub Personal Access Token with **repo** + **workflow** scopes

### Step 1 — Fill in secrets

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your real values:
#   jenkins_admin_password, github_token, domain_name
```

### Step 2 — Bootstrap the S3 backend (first time only)

```bash
# Comment out the backend block in backend.tf, then:
terraform init
terraform apply -target=module.s3_backend
# Uncomment backend.tf, then migrate state:
terraform init -migrate-state   # answer "yes"
```

### Step 3 — Deploy everything

```bash
terraform apply
```

> **Note:** The first `terraform apply` creates the cluster, Jenkins, ArgoCD, and Ingress objects.
> The ALB hostnames are only available after the ALB Ingress Controller provisions the load balancers.
> Run `terraform apply` a second time to create the Route53 ALIAS records.

### Step 4 — Connect kubectl

```bash
aws eks update-kubeconfig --region us-west-2 --name lesson-8-9-eks
```

### Step 5 — Update Jenkinsfile with your ECR account ID

After `terraform apply`, copy the `ecr_repository_url` output value and replace `ACCOUNT_ID` in `Jenkinsfile`:

```bash
terraform output ecr_repository_url
# e.g. 123456789012.dkr.ecr.us-west-2.amazonaws.com/lesson-8-9-ecr
```

Edit `Jenkinsfile` line `ECR_REGISTRY = "ACCOUNT_ID.dkr.ecr.us-west-2.amazonaws.com"`.

---

## How to Check the Jenkins Pipeline

### Get Jenkins URL

```bash
terraform output jenkins_url
# https://jenkins.your-domain.com
```

Or, without a custom domain:

```bash
kubectl get svc -n jenkins jenkins
# Copy the EXTERNAL-IP from the LoadBalancer service
```

### Login

- **Username:** value of `jenkins_admin_username` (default: `admin`)
- **Password:** value of `jenkins_admin_password` from `terraform.tfvars`

### Run the pipeline

1. Open Jenkins UI → click **seed-job** → **Build Now**
   - This creates the `django-docker-build` pipeline job automatically
2. Click **django-docker-build** → **Build Now**
3. Watch **Console Output** — you will see:
   - Kaniko building and pushing the image to ECR
   - git clone, sed replacing the tag, git push

### Verify ECR image

```bash
aws ecr describe-images \
  --repository-name lesson-8-9-ecr \
  --region us-west-2 \
  --query 'imageDetails[*].{Tag:imageTags[0],Pushed:imagePushedAt}' \
  --output table
```

---

## How to See the Result in ArgoCD

### Get ArgoCD URL

```bash
terraform output argocd_url
# https://argocd.your-domain.com
```

Or, without a custom domain:

```bash
kubectl get svc -n argocd argo-cd-server
```

### Login

```bash
# Get the initial admin password
terraform output argocd_admin_password_command
# Run the printed command, e.g.:
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath='{.data.password}' | base64 -d
```

**Username:** `admin`

### What to look for

1. Open **Applications** → select **django-app**
2. Status should be **Synced** and **Healthy**
3. After Jenkins pushes a new tag, ArgoCD auto-syncs within ~3 minutes (default polling interval)
4. The **History** tab shows each sync with the commit that triggered it

### Verify pods were updated

```bash
kubectl get pods -n default
kubectl describe pod -n default -l app.kubernetes.io/name=django-app \
  | grep Image
# Should show the new ECR tag: v1.0.N
```

---

## Key Variables

| Variable | Description | Default |
|---|---|---|
| `aws_region` | AWS region | `us-west-2` |
| `project_name` | Prefix for all resource names | `lesson-8-9` |
| `jenkins_admin_username` | Jenkins login username | `admin` |
| `jenkins_admin_password` | Jenkins login password | *(required)* |
| `github_username` | GitHub username for Jenkins + ArgoCD | *(required)* |
| `github_token` | GitHub PAT (repo + workflow scopes) | *(required, sensitive)* |
| `domain_name` | Route53 domain for HTTPS ingress | *(required for ingress module)* |

---

## Teardown

```bash
# 1. Remove Helm releases (deprovisions ALBs and PVCs)
helm uninstall jenkins -n jenkins
helm uninstall argo-cd -n argocd

# 2. Destroy all infrastructure
terraform destroy

# WARNING: terraform destroy also deletes the S3 bucket and DynamoDB table.
# On the next deploy you will need to bootstrap again (Step 2 above).
```

---

## Security Notes

- Jenkins admin password is stored in a Kubernetes Secret, never in `values.yaml`
- GitHub token is injected into Jenkins via a Kubernetes Secret + `extraEnvVars` (not plain text in Helm values)
- ArgoCD repo credentials are stored as a labeled Kubernetes Secret, not in chart values
- Kaniko authenticates to ECR via IRSA (IAM Roles for Service Accounts) — no AWS keys in the cluster
- EBS volumes are encrypted (`gp3`, `encrypted: true`)
- Plugin versions are pinned (not `:latest`) for reproducibility
