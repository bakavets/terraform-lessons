variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
}

variable "aws_iam_service_linked_role_autoscaling" {
  description = "Controls if AWS IAM Service linked role Autoscaling should be created."
  type        = bool
  default     = false
}
