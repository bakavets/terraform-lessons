terraform {
  backend "s3" {
    bucket         = "aws-terraform-states-backend"
    key            = "networking/sg/terraform.tfstate"
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
      "OwnerEmail"      = "devops@test.com"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "aws-terraform-states-backend"
    key    = "networking/vpc/terraform.tfstate"
    region = "eu-north-1"
  }
}

resource "aws_security_group" "sg" {
  name   = "bastion-host-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Bastion-host-SG-SSH"
  }
}