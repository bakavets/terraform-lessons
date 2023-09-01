# sg
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.63.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.63.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.all_worker_node_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_prefix"></a> [deployment\_prefix](#input\_deployment\_prefix) | Prefix of the deployment | `string` | n/a | yes |
| <a name="input_ssh_ingress_cidr_blocks"></a> [ssh\_ingress\_cidr\_blocks](#input\_ssh\_ingress\_cidr\_blocks) | Allowed CIDR blocks for the SSH for the worker K8s Nodes. | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | AWS VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_worker_node_groups_sg_id"></a> [all\_worker\_node\_groups\_sg\_id](#output\_all\_worker\_node\_groups\_sg\_id) | K8s Nodes SG |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
