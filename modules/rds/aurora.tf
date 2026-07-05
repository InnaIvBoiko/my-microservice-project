# Cluster-level parameter group for Aurora
resource "aws_rds_cluster_parameter_group" "aurora" {
  count  = var.use_aurora ? 1 : 0
  name   = "${var.name}-aurora-cpg"
  family = var.parameter_group_family_aurora

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.key
      value        = parameter.value
      apply_method = "pending-reboot"
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

resource "aws_rds_cluster" "aurora" {
  count = var.use_aurora ? 1 : 0

  cluster_identifier              = var.name
  engine                          = var.engine_cluster
  engine_version                  = var.engine_version_cluster
  master_username                 = var.username
  master_password                 = var.password
  database_name                   = var.db_name
  db_subnet_group_name            = aws_db_subnet_group.default.name
  vpc_security_group_ids          = [aws_security_group.rds.id]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora[0].name
  # Aurora requires backup_retention_period >= 1
  backup_retention_period    = var.backup_retention_period > 0 ? var.backup_retention_period : 7
  storage_encrypted          = var.storage_encrypted
  deletion_protection        = var.deletion_protection
  copy_tags_to_snapshot      = var.copy_tags_to_snapshot
  skip_final_snapshot        = true

  # Serverless v2 scaling — required when using instance_class = "db.serverless".
  # Free-tier accounts cannot use provisioned Aurora; Serverless v2 removes that restriction.
  serverlessv2_scaling_configuration {
    min_capacity = 0.5
    max_capacity = 1.0
  }

  tags = var.tags
}

# One resource per instance (writer + optional readers)
resource "aws_rds_cluster_instance" "aurora" {
  count = var.use_aurora ? var.aurora_instance_count : 0

  identifier                 = "${var.name}-${count.index}"
  cluster_identifier         = aws_rds_cluster.aurora[0].id
  engine                     = var.engine_cluster
  engine_version             = var.engine_version_cluster
  instance_class             = var.instance_class
  publicly_accessible        = var.publicly_accessible
  db_subnet_group_name       = aws_db_subnet_group.default.name
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  tags = var.tags
}
