# IAM role for the EKS cluster
resource "aws_iam_role" "eks" {
  name = "${var.cluster_name}-eks-cluster"

  # Trust policy allowing the EKS service to assume this role
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "eks.amazonaws.com"
      }
    }
  ]
}
POLICY
}

# Attach the AmazonEKSClusterPolicy to grant EKS the permissions it needs
resource "aws_iam_role_policy_attachment" "eks" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}

# Create the EKS cluster
resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    endpoint_private_access = true  # API server reachable from within the VPC
    endpoint_public_access  = true  # API server reachable from the internet
    subnet_ids              = var.subnet_ids
  }

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true  # Grant admin rights to the cluster creator
  }

  depends_on = [aws_iam_role_policy_attachment.eks]
}
