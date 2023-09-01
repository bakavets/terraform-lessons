# eks
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.47 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.4.1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | 19.15.3 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_eks_managed_node_sg_ids"></a> [additional\_eks\_managed\_node\_sg\_ids](#input\_additional\_eks\_managed\_node\_sg\_ids) | K8s Nodes SG IDs | `list(string)` | n/a | yes |
| <a name="input_cloudwatch_log_group_retention_in_days"></a> [cloudwatch\_log\_group\_retention\_in\_days](#input\_cloudwatch\_log\_group\_retention\_in\_days) | Number of days to retain log events. Default retention - 30 days | `number` | `30` | no |
| <a name="input_cluster_enabled_log_types"></a> [cluster\_enabled\_log\_types](#input\_cluster\_enabled\_log\_types) | A list of the desired control plane logs to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html) | `list(string)` | `[]` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.24`) | `string` | n/a | yes |
| <a name="input_create_cloudwatch_log_group"></a> [create\_cloudwatch\_log\_group](#input\_create\_cloudwatch\_log\_group) | Determines whether a log group is created by this module for the cluster logs. If not, AWS will automatically create one if logging is enabled | `bool` | `false` | no |
| <a name="input_deployment_prefix"></a> [deployment\_prefix](#input\_deployment\_prefix) | Prefix of the deployment | `string` | n/a | yes |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The KMS key to use when encrypting the root storage device, EKS Secrets, SSH Key pair etc. | `string` | n/a | yes |
| <a name="input_mgmt_desired_size"></a> [mgmt\_desired\_size](#input\_mgmt\_desired\_size) | Desired worker capacity in the autoscaling group | `number` | n/a | yes |
| <a name="input_mgmt_instance_types"></a> [mgmt\_instance\_types](#input\_mgmt\_instance\_types) | The ALL types of EC2 instances MUST have RAM: 16.0GiB	and CPU: 4vCPUs. Make sure that default EC2 insatnce types exist within selected AWS region. | `list(string)` | n/a | yes |
| <a name="input_mgmt_max_size"></a> [mgmt\_max\_size](#input\_mgmt\_max\_size) | Maximum worker capacity in the autoscaling group | `number` | n/a | yes |
| <a name="input_mgmt_min_size"></a> [mgmt\_min\_size](#input\_mgmt\_min\_size) | Minimum worker capacity in the autoscaling group. NOTE: Change in this paramater will affect the asg\_desired\_capacity, like changing its value to 2 will change asg\_desired\_capacity value to 2 but bringing back it to 1 will not affect the asg\_desired\_capacity. | `number` | n/a | yes |
| <a name="input_private_subnets_ids"></a> [private\_subnets\_ids](#input\_private\_subnets\_ids) | A list of VPC Private subnet IDs | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The Amazon Resource Name (ARN) of the cluster |
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Base64 encoded certificate data required to communicate with the cluster |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for EKS control plane. |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | EKS cluster ID. |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | The URL on the EKS cluster OIDC Issuer. |
| <a name="output_cluster_security_group_id"></a> [cluster\_security\_group\_id](#output\_cluster\_security\_group\_id) | Security group ids attached to the cluster control plane. |
| <a name="output_eks_mng_management_iam_role_arn"></a> [eks\_mng\_management\_iam\_role\_arn](#output\_eks\_mng\_management\_iam\_role\_arn) | IAM Role ARN of EKS Managed Node group. |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | The ARN of the OIDC Provider. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
