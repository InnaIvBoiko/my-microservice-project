# My microservice project — Lesson 7

Kubernetes cluster on AWS (EKS) with a Django application deployed via Helm.
Infrastructure provisioned with Terraform; Docker image stored in ECR.

## Project structure

```
├── main.tf                  # Wires all modules together
├── backend.tf               # Remote state backend (S3 + DynamoDB)
├── outputs.tf               # Aggregated outputs
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
│   └── eks/                 # EKS cluster + node group
│       ├── eks.tf           # Control plane, IAM role
│       ├── node.tf          # Worker nodes (EC2), IAM policies
│       ├── variables.tf
│       └── outputs.tf
│
├── docker/
│   └── django/              # Django application
│       ├── Dockerfile
│       ├── requirements.txt
│       └── my_project/
│
└── charts/
    └── django-app/
        ├── Chart.yaml
        ├── values.yaml      # Image, service, config, autoscaler params
        └── templates/
            ├── deployment.yaml   # Django pods with ConfigMap + Secret
            ├── service.yaml      # LoadBalancer for external access
            ├── configmap.yaml    # Non-sensitive env vars (DB host, port…)
            ├── secret.yaml       # Sensitive env vars (DB password)
            └── hpa.yaml          # Autoscaler: 2–6 pods at >70% CPU
```

## Modules

- **s3-backend** — S3 bucket (versioning, AES-256 encryption, public access blocked, 90-day lifecycle policy) + DynamoDB table for state locking.

- **vpc** — VPC (`10.0.0.0/16`) with 3 public and 3 private subnets across three availability zones, Internet Gateway, NAT Gateway with Elastic IP, and route tables.

- **ecr** — ECR repository with scan-on-push, AES-256 encryption, access policy scoped to the current AWS account, and a lifecycle rule keeping only the last 10 images.

- **eks** — EKS control plane with an IAM role and a managed node group of `t3.small` EC2 instances. Worker nodes have policies for EKS, VPC CNI, and ECR read access.

## Helm chart

| Template | Purpose |
|---|---|
| `deployment.yaml` | Django pods with resource limits, env vars from ConfigMap and Secret, liveness and readiness probes (tcpSocket on port 8000) |
| `service.yaml` | `LoadBalancer` — external port from `values.yaml`, internal port 8000 |
| `configmap.yaml` | Non-sensitive vars: `POSTGRES_HOST`, `PORT`, `USER`, `DB`, `ALLOWED_HOSTS` |
| `secret.yaml` | Sensitive vars: `POSTGRES_PASSWORD` |
| `hpa.yaml` | Scales pods from 2 to 6 when CPU exceeds 70% |

### Health probes

Both probes use `tcpSocket` on the container port so that Kubernetes checks TCP connectivity without making an HTTP request (which would trigger Django's `ALLOWED_HOSTS` validation on the pod IP).

```yaml
livenessProbe:
  tcpSocket:
    port: 8000
  initialDelaySeconds: 30
  periodSeconds: 10
  failureThreshold: 3
readinessProbe:
  tcpSocket:
    port: 8000
  initialDelaySeconds: 15
  periodSeconds: 5
  failureThreshold: 3
```

### Sensitive values

Passwords and the ECR repository URL are **not stored in `values.yaml`**. Pass them at install time:

```bash
helm install django-app ./charts/django-app \
  --set image.repository=<ecr-url> \
  --set secret.postgresPassword=<password>
```

## Deployment

```bash
# 1. Bootstrap: create S3 bucket first (backend does not exist yet)
# Comment out the backend block in backend.tf, then:
terraform init
terraform apply -target=module.s3_backend
# Uncomment backend.tf, then migrate state:
terraform init -migrate-state   # answer yes

# 2. Create the rest of the infrastructure (VPC, EKS, ECR)
terraform apply

# 3. Connect kubectl to the cluster
aws eks update-kubeconfig --region us-west-2 --name lesson-7-eks

# 4. Build and push Django image to ECR (linux/amd64 required for EKS t3 nodes)
aws ecr get-login-password --region us-west-2 | \
  docker login --username AWS --password-stdin 740948698725.dkr.ecr.us-west-2.amazonaws.com
cd docker/django
docker build --platform linux/amd64 -t django-app:v2 .
docker tag django-app:v2 740948698725.dkr.ecr.us-west-2.amazonaws.com/lesson-7-ecr:v2
docker push 740948698725.dkr.ecr.us-west-2.amazonaws.com/lesson-7-ecr:v2
cd ../..

# 5. Deploy with Helm (sensitive values passed via --set)
helm install django-app ./charts/django-app \
  --set image.repository=740948698725.dkr.ecr.us-west-2.amazonaws.com/lesson-7-ecr \
  --set secret.postgresPassword=<your-db-password>

# 6. Get the external URL
kubectl get service django-app-django
```

## Teardown

```bash
# 1. Remove Helm releases (also deprovisions the AWS LoadBalancer)
helm uninstall django-app

# 2. Wait until the LoadBalancer is fully removed, then destroy infrastructure
terraform destroy
```

## Main variables

| Variable | Description | Default |
|---|---|---|
| `aws_region` | AWS region | `us-west-2` |
| `project_name` | Resource name prefix | `lesson-7` |
| `instance_type` | EC2 node type | `t3.small` |

## Proof of deployment

| Resource | Screenshot |
|---|---|
| EKS cluster active | [EKS-lesson-7.png](public/images/EKS-lesson-7.png) |
| ECR repository with image | [ECR.png](public/images/ECR.png) |
| Helm install + kubectl output | [terminal-helm.png](public/images/terminal-helm.png) |
| Pods Running (1/1), Service, HPA | [terminal-kubectl.png](public/images/terminal-kubectl.png) |
| Django admin live on ELB URL | [django-administration.png](public/images/django-administration.png) |
