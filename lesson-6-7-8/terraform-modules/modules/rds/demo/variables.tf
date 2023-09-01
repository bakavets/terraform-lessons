variable "deployment_prefix" {
  description = "Prefix of the deployment"
  type        = string
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where DB cluster should be deployed"
}

variable "add_extra_cidr_blocks" {
  description = "Controls if extra CIDR blocks should be added."
  type        = bool
  default     = false
}

variable "extra_cidr_blocks" {
  type        = list(string)
  description = "Extra CIDR blocks to get access to database."
  default     = []
}

variable "all_worker_node_groups_sg_id" {
  type        = string
  description = "The common SG ID of K8s nodes"
}

variable "database_subnet_group" {
  type        = string
  description = "ID of database subnet group"
}

variable "engine" {
  description = "The database engine to use"
  type        = string
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
}

variable "family" {
  description = "The family of the DB parameter group"
  type        = string
}

variable "major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = string
}

variable "max_allocated_storage" {
  description = "Specifies the value for Storage Autoscaling"
  type        = number
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key"
  type        = string
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true"
  type        = bool
  default     = true
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled"
  type        = bool
  default     = false
}

variable "my_password" {
  description = "My password"
  type        = string
  sensitive   = true
}
