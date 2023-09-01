provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}

locals {
  cluster_name = var.cluster_name
}

module "eks" {
  source                          = "terraform-aws-modules/eks/aws"
  version                         = "19.15.3"
  cluster_name                    = local.cluster_name
  cluster_version                 = var.cluster_version
  vpc_id                          = var.vpc_id
  subnet_ids                      = var.private_subnets_ids
  enable_irsa                     = true
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  create_cloudwatch_log_group            = var.create_cloudwatch_log_group
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days
  cluster_enabled_log_types              = var.cluster_enabled_log_types

  eks_managed_node_group_defaults = {
    vpc_security_group_ids = var.additional_eks_managed_node_sg_ids
  }

  manage_aws_auth_configmap = true

  create_kms_key = false
  cluster_encryption_config = {
    provider_key_arn = var.kms_key_id
    resources        = ["secrets"]
  }

  tags = {
    "Name"            = local.cluster_name
    "Type"            = "Kubernetes Service"
    "K8s Description" = "Kubernetes for deployment related to ${var.deployment_prefix}"
  }

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    management = {
      min_size     = var.mgmt_min_size
      max_size     = var.mgmt_max_size
      desired_size = var.mgmt_desired_size

      instance_types = var.mgmt_instance_types
      capacity_type  = "ON_DEMAND"

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 50
            volume_type           = "gp3"
            encrypted             = true
            kms_key_id            = var.kms_key_id
            delete_on_termination = true
          }
        }
      }
      labels = {
        "node.k8s/role" = "management"
      }
    }
  }

  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Allow nodes to communicate with each other (all ports/protocols)."
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
  }
}
