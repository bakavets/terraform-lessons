terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-ec2-instance.git//.?ref=v4.0.0"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vpc" {
  config_path                             = "../vpc/"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "terragrunt-info", "show"] # Configure mock outputs for the "init", "validate", "plan", etc. commands that are returned when there are no outputs available (e.g the module hasn't been applied yet.)
  mock_outputs = {
    public_subnets = ["subnet-fake"]
  }
}

dependency "sg" {
  config_path                             = "../sg/"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "terragrunt-info", "show"]
  mock_outputs = {
    sg_id = "sg-fake-id"
  }
}

inputs = {
  name                   = "${include.root.inputs.deployment_prefix}-bastion-host"
  instance_type          = "t3.micro"
  ami                    = "ami-08bdc08970fcbd34a"
  vpc_security_group_ids = [dependency.sg.outputs.sg_id]
  subnet_id              = dependency.vpc.outputs.public_subnets[0]
  tags = {
    Name = "${include.root.locals.deployment_prefix}-bastion-host"
  }
}