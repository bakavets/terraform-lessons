variable "deployment_prefix" {
  description = "Prefix of the deployment"
  type        = string
}

variable "ecr_name" {
  description = "ECR name for service"
  type        = string
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE"
  type        = string
  default     = "IMMUTABLE"
}

variable "kms_key_id" {
  description = "The ARN KMS key"
  type        = string
}

variable "create_ecr_repository_policy" {
  description = "Determines whether to create ECR repository policy or not"
  type        = bool
  default     = false
}

variable "ecr_repository_policy" {
  type        = string
  description = "Elastic Container Registry Repository Policy."
  default     = ""
}

# Cache

variable "create_ecr_cache_repository" {
  description = "Determines whether to create cache ECR repository or not"
  type        = bool
  default     = false
}

variable "number_of_days_to_keep_cache_images" {
  description = "A number of days to keep cache images."
  type        = number
  default     = 14
}
