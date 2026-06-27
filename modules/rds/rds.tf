# Parameter group for a standard RDS instance
resource "aws_db_parameter_group" "rds" {
  count  = var.use_aurora ? 0 : 1
  name   = "${var.name}-rds-pg"
  family = var.parameter_group_family_rds

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.key
      value        = parameter.value
      apply_method = "pending-reboot"
    }
  }

  # Recreate the new group before destroying the old one to avoid
  # the brief window where the instance has no parameter group.
  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

resource "aws_db_instance" "default" {
  count = var.use_aurora ? 0 : 1

  identifier             = var.name
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.rds[0].name
  multi_az               = var.multi_az
  publicly_accessible    = var.publicly_accessible
  backup_retention_period    = var.backup_retention_period
  storage_encrypted          = var.storage_encrypted
  deletion_protection        = var.deletion_protection
  copy_tags_to_snapshot      = var.copy_tags_to_snapshot
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  skip_final_snapshot        = true

  tags = var.tags
}
