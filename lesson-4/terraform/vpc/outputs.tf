# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.demo_vpc.vpc_id
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.demo_vpc.public_subnets
}
