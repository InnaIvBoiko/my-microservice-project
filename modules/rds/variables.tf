variable "name" {
  description = "Identifier prefix used for all resources in this module (instance, cluster, subnet group, security group)"
  type        = string
}

variable "use_aurora" {
  description = "When true, creates an Aurora cluster + instances; when false, creates a standard RDS instance"
  type        = bool
  default     = false
}

# ---------------------------------------------------------------------------
# Engine — standard RDS
# ---------------------------------------------------------------------------

variable "engine" {
  description = "Database engine for the standard RDS instance (e.g. postgres, mysql)"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Engine version for the standard RDS instance (e.g. 16.9)"
  type        = string
  default     = "16.9"
}

variable "parameter_group_family_rds" {
  description = "Parameter group family for the standard RDS instance (e.g. postgres16, mysql8.0)"
  type        = string
  default     = "postgres16"
}

# ---------------------------------------------------------------------------
# Engine — Aurora cluster
# ---------------------------------------------------------------------------

variable "engine_cluster" {
  description = "Database engine for the Aurora cluster (e.g. aurora-postgresql, aurora-mysql)"
  type        = string
  default     = "aurora-postgresql"
}

variable "engine_version_cluster" {
  description = "Engine version for the Aurora cluster (e.g. 15.3)"
  type        = string
  default     = "15.3"
}

variable "parameter_group_family_aurora" {
  description = "Parameter group family for the Aurora cluster (e.g. aurora-postgresql15, aurora-mysql8.0)"
  type        = string
  default     = "aurora-postgresql15"
}

variable "aurora_instance_count" {
  description = "Total number of Aurora cluster instances (1 writer + N-1 readers)"
  type        = number
  default     = 2
}

# ---------------------------------------------------------------------------
# Compute & storage
# ---------------------------------------------------------------------------

variable "instance_class" {
  description = "RDS / Aurora instance class (e.g. db.t3.micro, db.r6g.large)"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Allocated storage in GiB (standard RDS only; Aurora manages storage automatically)"
  type        = number
  default     = 20
}

# ---------------------------------------------------------------------------
# Credentials & database
# ---------------------------------------------------------------------------

variable "db_name" {
  description = "Name of the initial database to create"
  type        = string
}

variable "username" {
  description = "Master username for the database"
  type        = string
}

variable "password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}

# ---------------------------------------------------------------------------
# Networking
# ---------------------------------------------------------------------------

variable "vpc_id" {
  description = "ID of the VPC where the database will be deployed"
  type        = string
}

variable "subnet_private_ids" {
  description = "List of private subnet IDs (used when publicly_accessible = false)"
  type        = list(string)
}

variable "subnet_public_ids" {
  description = "List of public subnet IDs (used when publicly_accessible = true)"
  type        = list(string)
}

variable "publicly_accessible" {
  description = "Whether the database endpoint is publicly reachable"
  type        = bool
  default     = false
}

variable "db_port" {
  description = "Port the database listens on (5432 for PostgreSQL, 3306 for MySQL)"
  type        = number
  default     = 5432
}

variable "ingress_cidr_blocks" {
  description = "CIDR blocks allowed to connect to the database port"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# ---------------------------------------------------------------------------
# High availability & backups
# ---------------------------------------------------------------------------

variable "multi_az" {
  description = "Enable Multi-AZ standby for the standard RDS instance (not applicable to Aurora)"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups (0 disables backups for standard RDS; Aurora requires >= 1)"
  type        = number
  default     = 0
}

# ---------------------------------------------------------------------------
# Security & maintenance
# ---------------------------------------------------------------------------

variable "storage_encrypted" {
  description = "Encrypt the DB storage at rest using AES-256"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Prevent accidental deletion of the DB instance or cluster (set true in production)"
  type        = bool
  default     = false
}

variable "copy_tags_to_snapshot" {
  description = "Copy all instance/cluster tags to automated and manual snapshots"
  type        = bool
  default     = true
}

variable "auto_minor_version_upgrade" {
  description = "Automatically apply minor engine upgrades during the maintenance window"
  type        = bool
  default     = true
}

# ---------------------------------------------------------------------------
# Parameters & tags
# ---------------------------------------------------------------------------

variable "parameters" {
  description = "Map of parameter name → value to set in the DB parameter group (e.g. max_connections, log_statement, work_mem)"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to all resources created by this module"
  type        = map(string)
  default     = {}
}
