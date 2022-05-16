terraform {
  backend "s3" {
    bucket         = "demo-terraform-states-backend"
    key            = "vpc/terraform.tfstate"
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

module "demo_vpc" {
  source            = "../../modules/vpc/"
  cidr              = "10.10.0.0"
  deployment_prefix = local.deployment_prefix
}