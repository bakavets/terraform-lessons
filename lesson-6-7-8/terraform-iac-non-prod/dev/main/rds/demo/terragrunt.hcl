terraform {
  source = "${include.root.locals.source_url}//modules/rds/demo?ref=${include.root.locals.source_version}"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vpc" {
  config_path                             = "../../networking/vpc/"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "providers", "terragrunt-info", "show"]
  mock_outputs_merge_strategy_with_state  = "shallow"
  mock_outputs = {
    vpc_id                = "fake-vpc-id"
    database_subnet_group = "fake-database-subnet-group-id"
  }
}

dependency "sg" {
  config_path                             = "../../networking/sg/"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "providers", "terragrunt-info", "show"]
  mock_outputs = {
    all_worker_node_groups_sg_id = "fake-sg-ids"
  }
}

dependency "kms" {
  config_path                             = "../../kms/"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "providers", "terragrunt-info", "show"]
  mock_outputs = {
    kms_deployment_key_arn = "arn:aws:kms:eu-west-1:123345678900:key/fake-kms-key"
  }
}

inputs = {
  vpc_id                       = dependency.vpc.outputs.vpc_id
  database_subnet_group        = dependency.vpc.outputs.database_subnet_group
  all_worker_node_groups_sg_id = dependency.sg.outputs.all_worker_node_groups_sg_id
  kms_key_id                   = dependency.kms.outputs.kms_deployment_key_arn
  engine                       = "mysql"
  engine_version               = "8.0.32"
  family                       = "mysql8.0"
  major_engine_version         = "8.0"
  instance_class               = "db.t4g.small"
  allocated_storage            = 30
  max_allocated_storage        = 200
  multi_az                     = false
  deletion_protection          = false
  add_extra_cidr_blocks        = false
  extra_cidr_blocks            = [] # Example: ["10.242.2.0/24", "10.246.110.0/24"]
}
