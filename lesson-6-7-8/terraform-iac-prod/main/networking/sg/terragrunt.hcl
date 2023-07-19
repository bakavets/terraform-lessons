terraform {
  source = "${include.root.locals.source_url}//modules/networking/sg?ref=${include.root.locals.source_version}"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vpc" {
  config_path                             = "../vpc"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "providers", "terragrunt-info", "show"]
  mock_outputs = {
    vpc_id         = "fake-vpc-id"
    vpc_cidr_block = "10.0.0.0/16"
  }
}

inputs = {
  vpc_id                  = dependency.vpc.outputs.vpc_id
  ssh_ingress_cidr_blocks = [dependency.vpc.outputs.vpc_cidr_block]
}
