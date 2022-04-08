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
| [aws_cloudwatch_log_group.log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_service.jenkins_ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.jenkins_task_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_lb_listener.lb_https_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.lb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.lb_listener_redirect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.lb_tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_security_groups"></a> [additional\_security\_groups](#input\_additional\_security\_groups) | Additional Security Groups Id's | `list(string)` | `[]` | no |
| <a name="input_all_cidr_blocks"></a> [all\_cidr\_blocks](#input\_all\_cidr\_blocks) | All Subnets CIDR Blocks | `list(string)` | n/a | yes |
| <a name="input_all_subnets_ids"></a> [all\_subnets\_ids](#input\_all\_subnets\_ids) | All Subnets IDs | `list(string)` | n/a | yes |
| <a name="input_all_subnets_map"></a> [all\_subnets\_map](#input\_all\_subnets\_map) | All Subnets | <pre>map(object({<br>    availability_zone = string<br>    cidr_block        = string<br>    id                = string<br>  }))</pre> | n/a | yes |
| <a name="input_application"></a> [application](#input\_application) | Application Name | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | n/a | `string` | `""` | no |
| <a name="input_cloud_watch_retention_in_days"></a> [cloud\_watch\_retention\_in\_days](#input\_cloud\_watch\_retention\_in\_days) | AWS Cloud Watch Retention Period in Days | `number` | `7` | no |
| <a name="input_ecs_cluster_id"></a> [ecs\_cluster\_id](#input\_ecs\_cluster\_id) | AWS ECS Cluster ID | `string` | n/a | yes |
| <a name="input_efs_access_point_id"></a> [efs\_access\_point\_id](#input\_efs\_access\_point\_id) | EFS Access Point ID | `string` | n/a | yes |
| <a name="input_efs_file_system_id"></a> [efs\_file\_system\_id](#input\_efs\_file\_system\_id) | EFS Filesystem ID | `string` | n/a | yes |
| <a name="input_efs_mount_point"></a> [efs\_mount\_point](#input\_efs\_mount\_point) | EFS Mounting Point in EC2 | `string` | `"/mnt/efs"` | no |
| <a name="input_efs_root_directory_path"></a> [efs\_root\_directory\_path](#input\_efs\_root\_directory\_path) | EFS Mounting Point in EC2 | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment Name | `string` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | Container Image | `string` | n/a | yes |
| <a name="input_jenkins_execution_role_arn"></a> [jenkins\_execution\_role\_arn](#input\_jenkins\_execution\_role\_arn) | AWS IAM Execution Role ARN | `string` | n/a | yes |
| <a name="input_jenkins_role_arn"></a> [jenkins\_role\_arn](#input\_jenkins\_role\_arn) | AWS IAM Role ARN | `string` | n/a | yes |
| <a name="input_jnlp_port"></a> [jnlp\_port](#input\_jnlp\_port) | Agent Port | `number` | `50000` | no |
| <a name="input_loadbalancer_arn"></a> [loadbalancer\_arn](#input\_loadbalancer\_arn) | AWS EC2 LoadBalancer ARN | `string` | n/a | yes |
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
| <a name="input_tags"></a> [tags](#input\_tags) | description | `map(string)` | <pre>{<br>  "ansible": false,<br>  "deployer": "TBD",<br>  "iac": "terraform",<br>  "owner": "SRE",<br>  "project": "TBD",<br>  "region": "TBD",<br>  "repo": "https://github.com/PasseiDireto/terraform-jenkins-iac.git",<br>  "stack": "TBD",<br>  "tier": "infra"<br>}</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | AWS VPC ID | `string` | n/a | yes |

## Outputs

No outputs.
