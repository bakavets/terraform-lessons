variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
}

variable "vpc_id" {
  description = "AWS VPC ID."
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "List of allowed CIDR blocks for SSH."
  type        = list(string)
}