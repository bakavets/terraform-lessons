# Kubernetes worker node SG
resource "aws_security_group" "all_worker_node_groups" {
  name        = "${var.deployment_prefix}-for-all-node-groups-sg"
  vpc_id      = var.vpc_id
  description = "What does this rule enable"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Inbound traffic only from internal VPC"
    cidr_blocks = var.ssh_ingress_cidr_blocks
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.10.0.0/16"]
    description = "What does this rule enable"
  }

  tags = {
    "Name"        = "${var.deployment_prefix}-for-all-node-groups-sg"
    "Description" = "Inbound traffic only from internal VPC"
  }
}
