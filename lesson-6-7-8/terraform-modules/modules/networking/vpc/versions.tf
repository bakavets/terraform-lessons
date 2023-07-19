terraform {
  required_version = ">= 1.0.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "<= 4.67.0"
    }
  }
}
