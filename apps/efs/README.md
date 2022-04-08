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
| [aws_efs_access_point.jenkins_efs_ap](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_access_point) | resource |
| [aws_efs_file_system.jenkins_efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_file_system_policy.efs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system_policy) | resource |
| [aws_efs_mount_target.jenkins_efs_mounting_targets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_security_groups"></a> [additional\_security\_groups](#input\_additional\_security\_groups) | Additional Security Groups Id's | `list(string)` | `[]` | no |
| <a name="input_all_cidr_blocks"></a> [all\_cidr\_blocks](#input\_all\_cidr\_blocks) | All Subnets CIDR Blocks | `list(string)` | n/a | yes |
| <a name="input_all_subnets_ids"></a> [all\_subnets\_ids](#input\_all\_subnets\_ids) | All Subnets IDs | `list(string)` | n/a | yes |
| <a name="input_all_subnets_map"></a> [all\_subnets\_map](#input\_all\_subnets\_map) | All Subnets | <pre>map(object({<br>    availability_zone = string<br>    cidr_block        = string<br>    id                = string<br>  }))</pre> | n/a | yes |
| <a name="input_application"></a> [application](#input\_application) | Application Name | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_efs_root_directory_path"></a> [efs\_root\_directory\_path](#input\_efs\_root\_directory\_path) | EFS Mounting Point | `string` | `"/jenkins"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment Name | `string` | n/a | yes |
| <a name="input_private_cidr_blocks"></a> [private\_cidr\_blocks](#input\_private\_cidr\_blocks) | Private Subnets CIDR Blocks | `list(string)` | n/a | yes |
| <a name="input_private_subnets_ids"></a> [private\_subnets\_ids](#input\_private\_subnets\_ids) | Private Subnets IDs | `list(string)` | n/a | yes |
| <a name="input_private_subnets_map"></a> [private\_subnets\_map](#input\_private\_subnets\_map) | Private Subnets | <pre>map(object({<br>    availability_zone = string<br>    cidr_block        = string<br>    id                = string<br>  }))</pre> | n/a | yes |
| <a name="input_public_cidr_blocks"></a> [public\_cidr\_blocks](#input\_public\_cidr\_blocks) | Public Subnets CIDR Blocks | `list(string)` | n/a | yes |
| <a name="input_public_subnets_ids"></a> [public\_subnets\_ids](#input\_public\_subnets\_ids) | Public Subnets IDs | `list(string)` | n/a | yes |
| <a name="input_public_subnets_map"></a> [public\_subnets\_map](#input\_public\_subnets\_map) | Public Subnets | <pre>map(object({<br>    availability_zone = string<br>    cidr_block        = string<br>    id                = string<br>  }))</pre> | n/a | yes |
| <a name="input_security_group_efs_id"></a> [security\_group\_efs\_id](#input\_security\_group\_efs\_id) | EFS Security Group ID | `string` | n/a | yes |
| <a name="input_security_group_jenkins_agent_id"></a> [security\_group\_jenkins\_agent\_id](#input\_security\_group\_jenkins\_agent\_id) | Jenkins Agent Security Group ID | `string` | n/a | yes |
| <a name="input_security_group_jenkins_id"></a> [security\_group\_jenkins\_id](#input\_security\_group\_jenkins\_id) | Jenkins Security Groups ID | `string` | n/a | yes |
| <a name="input_security_group_loadbalancer_id"></a> [security\_group\_loadbalancer\_id](#input\_security\_group\_loadbalancer\_id) | LoadBalancer Security Groups ID | `string` | n/a | yes |
| <a name="input_selected_subnet_cidr_blocks"></a> [selected\_subnet\_cidr\_blocks](#input\_selected\_subnet\_cidr\_blocks) | Selected Subnets CIDR Blocks | `list(string)` | `[]` | no |
| <a name="input_selected_subnets_ids"></a> [selected\_subnets\_ids](#input\_selected\_subnets\_ids) | Selected Subnets IDs | `list(string)` | `[]` | no |
| <a name="input_selected_subnets_map"></a> [selected\_subnets\_map](#input\_selected\_subnets\_map) | Selected Subnets Map | <pre>map(object({<br>    availability_zone = string<br>    cidr_block        = string<br>    id                = string<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | AWS Tags Standards | `map(string)` | <pre>{<br>  "ansible": false,<br>  "deployer": "TBD",<br>  "iac": "terraform",<br>  "owner": "SRE",<br>  "project": "TBD",<br>  "region": "TBD",<br>  "repo": "https://github.com/PasseiDireto/terraform-jenkins-iac.git",<br>  "stack": "TBD",<br>  "tier": "infra"<br>}</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | AWS VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_efs_access_point_id"></a> [efs\_access\_point\_id](#output\_efs\_access\_point\_id) | AWS EFS Access Point |
| <a name="output_efs_id"></a> [efs\_id](#output\_efs\_id) | AWS EFS Id |
| <a name="output_efs_mounting_targets"></a> [efs\_mounting\_targets](#output\_efs\_mounting\_targets) | AWS EFS Mounting Targets |
