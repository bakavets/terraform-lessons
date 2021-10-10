terraform {
  backend "s3" {
    bucket         = "aws-terraform-states-backend"
    key            = "networking/vpc/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "aws-terraform-states-lock"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.56.0"
    }
  }
  required_version = ">= 1.0.2"
}


provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      "TerminationDate" = "Permanent",
      "Environment"     = "Development",
      "Team"            = "DevOps",
      "DeployedBy"      = "Terraform",
      "Description"     = "For General Purposes"
      "OwnerEmail"      = "devops@example.com"
      "Type"            = "Networking"
    }
  }
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "3.7.0"
  name            = "Dev-VPC"
  cidr            = "10.10.0.0/16"
  azs             = data.aws_availability_zones.available.names
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
}
