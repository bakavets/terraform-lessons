variable "s3_bucket_name" {
  description = "S3 bucket for holding Terraform state. Must be globally unique."
  type        = string
}

variable "dynamodb_table_name" {
  description = "DynamoDB table for locking Terraform states"
  type        = string
}