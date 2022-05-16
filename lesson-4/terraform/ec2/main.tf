terraform {
  backend "s3" {
    bucket         = "demo-terraform-states-backend"
    key            = "ec2/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "demo-terraform-states-backend"
    encrypt        = true
  }
}

locals {
  deployment_prefix = "demo-terraform"
}

provider "aws" {
  region = "eu-north-1"
  default_tags {
    tags = {
      "TerminationDate"  = "Permanent",
      "Environment"      = "Development",
      "Team"             = "DevOps",
      "DeployedBy"       = "Terraform",
      "OwnerEmail"       = "devops@example.com"
      "DeploymentPrefix" = local.deployment_prefix
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "demo-terraform-states-backend"
    key    = "vpc/terraform.tfstate"
    region = "eu-north-1"
  }
}

data "terraform_remote_state" "sg" {
  backend = "s3"
  config = {
    bucket = "demo-terraform-states-backend"
    key    = "sg/terraform.tfstate"
    region = "eu-north-1"
  }
}

module "ec2" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "4.0.0"
  name                   = "${local.deployment_prefix}-bastion-host"
  instance_type          = "t3.micro"
  ami                    = "ami-08bdc08970fcbd34a"
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.sg_id]
  subnet_id              = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  tags = {
    Name = "${local.deployment_prefix}-bastion-host"
  }
}