terraform {
  backend "s3" {
    bucket         = "demo-terraform-states-backend"
    key            = "sg/terraform.tfstate"
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

module "sg" {
  source              = "../../modules/sg/"
  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
  allowed_cidr_blocks = ["10.10.0.0/16", "192.168.0.0/16"]
  deployment_prefix   = local.deployment_prefix
}