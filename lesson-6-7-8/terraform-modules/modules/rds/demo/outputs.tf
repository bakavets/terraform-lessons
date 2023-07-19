output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = module.demo.db_instance_address
}

output "db_instance_name" {
  description = "The database name"
  value       = module.demo.db_instance_name
}

output "db_instance_port" {
  description = "The database port"
  value       = module.demo.db_instance_port
}
