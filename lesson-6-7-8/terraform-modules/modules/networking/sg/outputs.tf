output "all_worker_node_groups_sg_id" {
  description = "K8s Nodes SG"
  value       = aws_security_group.all_worker_node_groups.id
}
