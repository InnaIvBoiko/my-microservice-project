# EKS add-on providing the Metrics API — required for the HorizontalPodAutoscaler
# in charts/django-app/templates/hpa.yaml to read pod CPU utilization.
resource "aws_eks_addon" "metrics_server" {
  cluster_name = aws_eks_cluster.eks.name
  addon_name   = "metrics-server"

  resolve_conflicts_on_update = "PRESERVE"

  depends_on = [aws_eks_node_group.general]
}
