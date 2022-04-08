## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0, < 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0, < 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_resource_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_resource_policy) | resource |
| [aws_datasync_location_efs.destination](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/datasync_location_efs) | resource |
| [aws_datasync_location_efs.source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/datasync_location_efs) | resource |
| [aws_datasync_task.task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/datasync_task) | resource |
| [aws_iam_role.datasync_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.datasync_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_efs_file_system.destination](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/efs_file_system) | data source |
| [aws_efs_file_system.source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/efs_file_system) | data source |
| [aws_iam_policy_document.cloudwatch_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input\_application) | Application Name | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | AWS S3 Bucket Name | `string` | n/a | yes |
| <a name="input_cloudwatch_loglevel"></a> [cloudwatch\_loglevel](#input\_cloudwatch\_loglevel) | AWS CouldWatch Loglevel for DataSync. LogLevel: OFF, BASIC or TRANSFER (default is OFF) | `string` | `"OFF"` | no |
| <a name="input_cron"></a> [cron](#input\_cron) | Cron Job | `string` | `"0 12PM ? * * *"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment Name | `string` | n/a | yes |
| <a name="input_file_system_destination_id"></a> [file\_system\_destination\_id](#input\_file\_system\_destination\_id) | EFS Filesystem Destination Id | `string` | n/a | yes |
| <a name="input_file_system_source_id"></a> [file\_system\_source\_id](#input\_file\_system\_source\_id) | EFS Filesystem Source Id | `string` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | AWS Security Groups | `list(string)` | n/a | yes |
| <a name="input_subdirectory"></a> [subdirectory](#input\_subdirectory) | SubDirectory | `string` | `"/"` | no |
| <a name="input_subnet_ids_destination"></a> [subnet\_ids\_destination](#input\_subnet\_ids\_destination) | AWS Subnet Ids | `list(string)` | n/a | yes |
| <a name="input_subnet_ids_source"></a> [subnet\_ids\_source](#input\_subnet\_ids\_source) | AWS Subnet Ids | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | AWS Tags | `map(any)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | AWS VPC Id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | AWS Account Id |
| <a name="output_datasync_destination_location"></a> [datasync\_destination\_location](#output\_datasync\_destination\_location) | AWS DataSync Destination Location |
| <a name="output_datasync_role"></a> [datasync\_role](#output\_datasync\_role) | AWS DataSync Role |
| <a name="output_datasync_role_id"></a> [datasync\_role\_id](#output\_datasync\_role\_id) | AWS DataSync Role Id |
| <a name="output_datasync_role_policy"></a> [datasync\_role\_policy](#output\_datasync\_role\_policy) | AWS DataSync Role Policy |
| <a name="output_datasync_source_location"></a> [datasync\_source\_location](#output\_datasync\_source\_location) | AWS DataSync Source Location |
| <a name="output_datasync_task"></a> [datasync\_task](#output\_datasync\_task) | AWS DataSync Task |
| <a name="output_file_system_destination_data"></a> [file\_system\_destination\_data](#output\_file\_system\_destination\_data) | AWS EFS Data |
| <a name="output_file_system_destination_dns_name"></a> [file\_system\_destination\_dns\_name](#output\_file\_system\_destination\_dns\_name) | AWS EFS DNS Name |
| <a name="output_file_system_destination_id"></a> [file\_system\_destination\_id](#output\_file\_system\_destination\_id) | AWS EFS Id |
| <a name="output_file_system_source_data"></a> [file\_system\_source\_data](#output\_file\_system\_source\_data) | AWS EFS Data |
| <a name="output_file_system_source_dns_name"></a> [file\_system\_source\_dns\_name](#output\_file\_system\_source\_dns\_name) | AWS EFS DNS Name |
| <a name="output_file_system_source_id"></a> [file\_system\_source\_id](#output\_file\_system\_source\_id) | AWS EFS Id |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | AWS VPC Id |
