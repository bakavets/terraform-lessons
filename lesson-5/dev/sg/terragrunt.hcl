terraform {
  source = "../../modules//sg/"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path                             = "../vpc/"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "terragrunt-info", "show"] # Configure mock outputs for the "init", "validate", "plan", etc. commands that are returned when there are no outputs available (e.g the module hasn't been applied yet.)
  mock_outputs = {
    vpc_id = "vpc-fake-id"
  }
}

inputs = {
  vpc_id              = dependency.vpc.outputs.vpc_id
  allowed_cidr_blocks = ["10.10.0.0/16", "192.168.0.0/16"]
}