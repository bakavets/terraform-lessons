locals {
  username               = "root"
  db_name                = "demo"
  db_instance_identifier = "${var.deployment_prefix}-demo-myrds"
}

################################################################################
# SecretsManager Secret
################################################################################

resource "random_password" "master_password" {
  length           = 32
  min_lower        = 1
  min_numeric      = 3
  min_special      = 3
  min_upper        = 3
  special          = true
  numeric          = true
  upper            = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "demo" {
  name        = "${var.deployment_prefix}-demo-myrds-db"
  description = "Demo credentials like Database password etc. for ${var.deployment_prefix} environment."
  kms_key_id  = var.kms_key_id
  tags = {
    "Name" = "${var.deployment_prefix}-demo-myrds-db"
    "Type" = "Secrets Manager"
  }
}

resource "aws_secretsmanager_secret_version" "demo" {
  secret_id = aws_secretsmanager_secret.demo.id
  secret_string = jsonencode({
    MYSQL_USER     = local.username
    MYSQL_PASSWORD = random_password.master_password.result
    MYSQL_DATABASE = local.db_name
    MYSQL_HOST     = module.demo.db_instance_address
    MYSQL_PORT     = module.demo.db_instance_port
    SUPER_SECRET   = var.my_password
  })
}

################################################################################
# Security Group
################################################################################

resource "aws_security_group" "demo" {
  name_prefix = "${var.deployment_prefix}-demo-rds-sg"
  description = "What does this rule enable"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${var.deployment_prefix}-demo-rds-sg"
  }
}

resource "aws_security_group_rule" "access_ingress_from_kubernetes_nodes" {
  type                     = "ingress"
  description              = "Inbound traffic only from Kubernetes nodes"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = var.all_worker_node_groups_sg_id
  security_group_id        = aws_security_group.demo.id
}


resource "aws_security_group_rule" "extra_inbound_access" {
  count             = var.add_extra_cidr_blocks ? 1 : 0
  type              = "ingress"
  description       = "Allow inbound access for additional CIDR blocks"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = var.extra_cidr_blocks
  security_group_id = aws_security_group.demo.id
}

################################################################################
# RDS Module
################################################################################

module "demo" {
  source  = "terraform-aws-modules/rds/aws"
  version = "5.9.0"

  identifier = local.db_instance_identifier

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine                       = var.engine
  engine_version               = var.engine_version
  family                       = var.family
  major_engine_version         = var.major_engine_version
  instance_class               = var.instance_class
  performance_insights_enabled = var.performance_insights_enabled

  storage_type          = "gp3"
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_encrypted     = true
  kms_key_id            = var.kms_key_id

  db_name                = local.db_name
  username               = local.username
  create_random_password = false
  password               = random_password.master_password.result
  port                   = 3306

  multi_az               = var.multi_az
  publicly_accessible    = false
  db_subnet_group_name   = var.database_subnet_group
  vpc_security_group_ids = [aws_security_group.demo.id]

  skip_final_snapshot              = false
  final_snapshot_identifier_prefix = "${local.db_instance_identifier}-final"

  auto_minor_version_upgrade = true
  maintenance_window         = "Mon:00:00-Mon:03:00"
  backup_retention_period    = 7
  backup_window              = "03:00-06:00"

  copy_tags_to_snapshot     = true
  deletion_protection       = var.deletion_protection
  create_db_option_group    = false
  create_db_parameter_group = true

  parameters = [
    {
      name  = "require_secure_transport"
      value = "1"
    }
  ]

  tags = {
    Name   = local.db_instance_identifier
    Type   = "Relational Database Service"
    Engine = "MySQL"
    Dummy  = "Tag_2"
  }
}
