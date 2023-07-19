data "aws_availability_zones" "available" {}

locals {
  cidr_part        = trimsuffix(var.cidr, ".0.0")
  eks_cluster_name = "${var.deployment_prefix}-eks-cluster"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name                               = "${var.deployment_prefix}-vpc"
  cidr                               = "${var.cidr}/16"
  azs                                = data.aws_availability_zones.available.names
  private_subnets                    = ["${local.cidr_part}.0.0/19", "${local.cidr_part}.32.0/19", "${local.cidr_part}.64.0/19"]
  public_subnets                     = ["${local.cidr_part}.96.0/22", "${local.cidr_part}.100.0/22", "${local.cidr_part}.104.0/22"]
  database_subnets                   = ["${local.cidr_part}.108.0/24", "${local.cidr_part}.109.0/24", "${local.cidr_part}.110.0/24"]
  intra_subnets                      = ["${local.cidr_part}.111.0/24", "${local.cidr_part}.112.0/24", "${local.cidr_part}.113.0/24"]
  enable_nat_gateway                 = true
  single_nat_gateway                 = var.single_nat_gateway
  one_nat_gateway_per_az             = var.one_nat_gateway_per_az
  enable_dns_hostnames               = true
  create_igw                         = true
  create_database_subnet_route_table = true

  tags = {
    "Name" = "${var.deployment_prefix}-VPC"
  }

  public_subnet_tags = {
    "Name"                                            = "public-subnet-${var.deployment_prefix}"
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                          = "1"
  }

  private_subnet_tags = {
    "Name"                                            = "private-subnet-${var.deployment_prefix}"
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"                 = "1"
  }

  database_subnet_tags = {
    "Name" = "database-subnet-${var.deployment_prefix}"
  }

  intra_subnet_tags = {
    "Name" = "intra-subnet-${var.deployment_prefix}"
  }

  intra_route_table_tags = {
    "Name" = "intra-route-table-${var.deployment_prefix}"
  }

  public_route_table_tags = {
    "Name" = "public-route-table-${var.deployment_prefix}"
  }

  database_route_table_tags = {
    "Name" = "database-route-table-${var.deployment_prefix}"
  }

  private_route_table_tags = {
    "Name" = "private-route-table-${var.deployment_prefix}"
  }
}
