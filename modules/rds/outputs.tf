output "db_endpoint" {
  description = "Primary connection endpoint of the database (writer endpoint for Aurora)"
  value       = var.use_aurora ? aws_rds_cluster.aurora[0].endpoint : aws_db_instance.default[0].endpoint
}

output "db_reader_endpoint" {
  description = "Read-only endpoint for Aurora clusters; null for standard RDS"
  value       = var.use_aurora ? aws_rds_cluster.aurora[0].reader_endpoint : null
}

output "db_port" {
  description = "Port the database listens on"
  value       = var.use_aurora ? aws_rds_cluster.aurora[0].port : aws_db_instance.default[0].port
}

output "db_name" {
  description = "Name of the initial database"
  value       = var.db_name
}

output "security_group_id" {
  description = "ID of the security group attached to the database"
  value       = aws_security_group.rds.id
}

output "subnet_group_name" {
  description = "Name of the DB subnet group"
  value       = aws_db_subnet_group.default.name
}
