variable "deployment_prefix" {
  description = "Prefix of the deployment"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnets_ids" {
  description = "A list of VPC Private subnet IDs"
  type        = list(string)
}

variable "additional_eks_managed_node_sg_ids" {
  description = "K8s Nodes SG IDs"
  type        = list(string)
}

variable "kms_key_id" {
  description = "The KMS key to use when encrypting the root storage device, EKS Secrets, SSH Key pair etc."
  type        = string
}

variable "mgmt_instance_types" {
  description = "The ALL types of EC2 instances MUST have RAM: 16.0GiB	and CPU: 4vCPUs. Make sure that default EC2 insatnce types exist within selected AWS region."
  type        = list(string)
}

variable "mgmt_min_size" {
  description = "Minimum worker capacity in the autoscaling group. NOTE: Change in this paramater will affect the asg_desired_capacity, like changing its value to 2 will change asg_desired_capacity value to 2 but bringing back it to 1 will not affect the asg_desired_capacity."
  type        = number
}

variable "mgmt_max_size" {
  description = "Maximum worker capacity in the autoscaling group"
  type        = number
}

variable "mgmt_desired_size" {
  description = "Desired worker capacity in the autoscaling group"
  type        = number
}

################################################################################
# CloudWatch Log Group
################################################################################

variable "create_cloudwatch_log_group" {
  description = "Determines whether a log group is created by this module for the cluster logs. If not, AWS will automatically create one if logging is enabled"
  type        = bool
  default     = false
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "Number of days to retain log events. Default retention - 30 days"
  type        = number
  default     = 30
}

variable "cluster_enabled_log_types" {
  description = "A list of the desired control plane logs to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)"
  type        = list(string)
  default     = []
}


variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.24`)"
  type        = string
}
