# kms

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.52.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.52.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_service_linked_role.autoscaling](https://registry.terraform.io/providers/hashicorp/aws/3.52.0/docs/resources/iam_service_linked_role) | resource |
| [aws_kms_alias.kms_deployment_key](https://registry.terraform.io/providers/hashicorp/aws/3.52.0/docs/resources/kms_alias) | resource |
| [aws_kms_key.kms_deployment_key](https://registry.terraform.io/providers/hashicorp/aws/3.52.0/docs/resources/kms_key) | resource |
| [aws_caller_identity.account](https://registry.terraform.io/providers/hashicorp/aws/3.52.0/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_iam_service_linked_role_autoscaling"></a> [aws\_iam\_service\_linked\_role\_autoscaling](#input\_aws\_iam\_service\_linked\_role\_autoscaling) | Controls if AWS IAM Service linked role Autoscaling should be created. | `bool` | `false` | no |
| <a name="input_deployment_prefix"></a> [deployment\_prefix](#input\_deployment\_prefix) | Prefix of the deployment. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kms_deployment_key_arn"></a> [kms\_deployment\_key\_arn](#output\_kms\_deployment\_key\_arn) | KMS Key ARN. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
