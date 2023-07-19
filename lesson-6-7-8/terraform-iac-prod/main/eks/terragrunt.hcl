terraform {
  source = "${include.root.locals.source_url}//modules/eks?ref=${include.root.locals.source_version}"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vpc" {
  config_path                             = "../networking/vpc/"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "providers", "terragrunt-info", "show"]
  mock_outputs = {
    vpc_id          = "fake-vpc-id"
    private_subnets = ["fake-db-subnet-ids"]
  }
}

dependency "sg" {
  config_path                             = "../networking/sg/"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "providers", "terragrunt-info", "show"]
  mock_outputs = {
    all_worker_node_groups_sg_id = "fake-sg-ids"
  }
}

dependency "kms" {
  config_path                             = "../kms/"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "providers", "terragrunt-info", "show"]
  mock_outputs = {
    kms_deployment_key_arn = "arn:aws:kms:eu-west-1:123345678900:key/fake-kms-key"
  }
}

inputs = {
  cluster_name                           = include.root.locals.eks_cluster_name
  vpc_id                                 = dependency.vpc.outputs.vpc_id
  private_subnets_ids                    = dependency.vpc.outputs.private_subnets
  additional_eks_managed_node_sg_ids     = [dependency.sg.outputs.all_worker_node_groups_sg_id]
  kms_key_id                             = dependency.kms.outputs.kms_deployment_key_arn
  cluster_version                        = "1.27"
  mgmt_instance_types                    = ["t3.xlarge"]
  mgmt_min_size                          = 2
  mgmt_max_size                          = 2
  mgmt_desired_size                      = 2
  create_cloudwatch_log_group            = false
  cloudwatch_log_group_retention_in_days = 30
  cluster_enabled_log_types              = [] # For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)
}
