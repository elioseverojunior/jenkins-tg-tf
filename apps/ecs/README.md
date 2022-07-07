## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0, < 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0, < 4.0.0 |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_ecs_cluster.jenkins_ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_iam_instance_profile.ecs_instance_profile_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ecs_instance_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.jenkins_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.jenkins_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.ecs_instance_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.jenkins_execution_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.jenkins_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.ecs_instance_role_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_launch_configuration.lc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_lb.load_balancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_key_pair.key_pair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/key_pair) | data source |
| [template_file.cluster_user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_security_groups"></a> [additional\_security\_groups](#input\_additional\_security\_groups) | Additional Security Groups Id's | `list(string)` | `[]` | no |
| <a name="input_cidr_blocks_all"></a> [all\_cidr\_blocks](#input\_all\_cidr\_blocks) | All Subnets CIDR Blocks | `list(string)` | n/a | yes |
| <a name="input_subnets_all_ids"></a> [all\_subnets\_ids](#input\_all\_subnets\_ids) | All Subnets IDs | `list(string)` | n/a | yes |
| <a name="input_subnets_all_map"></a> [all\_subnets\_map](#input\_all\_subnets\_map) | All Subnets | <pre>map(object({<br>    availability_zone = string<br>    cidr_block        = string<br>    id                = string<br>  }))</pre> | n/a | yes |
| <a name="input_application"></a> [application](#input\_application) | Application Name | `string` | n/a | yes |
| <a name="input_asg_desired_capacity"></a> [asg\_desired\_capacity](#input\_asg\_desired\_capacity) | AWS ASG Desired Capacity | `number` | `1` | no |
| <a name="input_asg_health_check_grace_period"></a> [asg\_health\_check\_grace\_period](#input\_asg\_health\_check\_grace\_period) | AWS ASG Health Check Grace Period | `number` | `300` | no |
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | AWS ASG Maximum Size | `number` | `1` | no |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | AWS ASG Minimum Capacity | `number` | `1` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | AWS ASG Associate Public Ip Address | `bool` | `false` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | n/a | `string` | `"arn::acm:certificate"` | no |
| <a name="input_cloud_watch_retention_in_days"></a> [cloud\_watch\_retention\_in\_days](#input\_cloud\_watch\_retention\_in\_days) | AWS Cloud Watch Retention Period in Days | `number` | `7` | no |
| <a name="input_efs_access_point_id"></a> [efs\_access\_point\_id](#input\_efs\_access\_point\_id) | EFS Access Point ID | `string` | n/a | yes |
| <a name="input_efs_file_system_id"></a> [efs\_file\_system\_id](#input\_efs\_file\_system\_id) | EFS Filesystem ID | `string` | n/a | yes |
| <a name="input_efs_mount_point"></a> [efs\_mount\_point](#input\_efs\_mount\_point) | EFS Mounting Point in EC2 | `string` | `"/mnt/efs"` | no |
| <a name="input_enable_internal_load_balancer"></a> [enable\_internal\_load\_balancer](#input\_enable\_internal\_load\_balancer) | LoadBalancer Security Groups ID | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment Name | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance Type | `string` | `"m5.xlarge"` | no |
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | AWS Key Pair Name. It should exists in your AWS Account. | `string` | n/a | yes |
| <a name="input_cidr_blocks_private"></a> [private\_cidr\_blocks](#input\_private\_cidr\_blocks) | Private Subnets CIDR Blocks | `list(string)` | n/a | yes |
| <a name="input_subnets_private_ids"></a> [private\_subnets\_ids](#input\_private\_subnets\_ids) | Private Subnets IDs | `list(string)` | n/a | yes |
| <a name="input_subnets_private_map"></a> [private\_subnets\_map](#input\_private\_subnets\_map) | Private Subnets | <pre>map(object({<br>    availability_zone = string<br>    cidr_block        = string<br>    id                = string<br>  }))</pre> | n/a | yes |
| <a name="input_cidr_blocks_public"></a> [public\_cidr\_blocks](#input\_public\_cidr\_blocks) | Public Subnets CIDR Blocks | `list(string)` | n/a | yes |
| <a name="input_subnets_public_ids"></a> [public\_subnets\_ids](#input\_public\_subnets\_ids) | Public Subnets IDs | `list(string)` | n/a | yes |
| <a name="input_subnets_public_map"></a> [public\_subnets\_map](#input\_public\_subnets\_map) | Public Subnets | <pre>map(object({<br>    availability_zone = string<br>    cidr_block        = string<br>    id                = string<br>  }))</pre> | n/a | yes |
| <a name="input_security_group_efs_id"></a> [security\_group\_efs\_id](#input\_security\_group\_efs\_id) | EFS Security Group ID | `string` | n/a | yes |
| <a name="input_security_group_jenkins_agent_id"></a> [security\_group\_jenkins\_agent\_id](#input\_security\_group\_jenkins\_agent\_id) | Jenkins Agent Security Group ID | `string` | n/a | yes |
| <a name="input_security_group_jenkins_id"></a> [security\_group\_jenkins\_id](#input\_security\_group\_jenkins\_id) | Jenkins Security Groups ID | `string` | n/a | yes |
| <a name="input_security_group_loadbalancer_id"></a> [security\_group\_loadbalancer\_id](#input\_security\_group\_loadbalancer\_id) | LoadBalancer Security Groups ID | `string` | n/a | yes |
| <a name="input_selected_subnet_cidr_blocks"></a> [selected\_subnet\_cidr\_blocks](#input\_selected\_subnet\_cidr\_blocks) | Selected Subnets CIDR Blocks | `list(string)` | `[]` | no |
| <a name="input_selected_subnets_ids"></a> [selected\_subnets\_ids](#input\_selected\_subnets\_ids) | Selected Subnets IDs | `list(string)` | `[]` | no |
| <a name="input_selected_subnets_map"></a> [selected\_subnets\_map](#input\_selected\_subnets\_map) | Selected Subnets Map | <pre>map(object({<br>    availability_zone = string<br>    cidr_block        = string<br>    id                = string<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | description | `map(string)` | <pre>{<br>  "ansible": false,<br>  "deployer": "TBD",<br>  "iac": "terraform",<br>  "owner": "SRE",<br>  "project": "TBD",<br>  "region": "TBD",<br>  "repo": "https://github.com/Agrium/tf-jenkins-br.git",<br>  "stack": "TBD",<br>  "tier": "infra"<br>}</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | AWS VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_asg"></a> [asg](#output\_asg) | AWS EC2 AutoScaling Group |
| <a name="output_ecs_cluster_id"></a> [ecs\_cluster\_id](#output\_ecs\_cluster\_id) | AWS ECS Cluster |
| <a name="output_jenkins_execution_role_arn"></a> [jenkins\_execution\_role\_arn](#output\_jenkins\_execution\_role\_arn) | AWS IAM Execution Role ARN |
| <a name="output_jenkins_role_arn"></a> [jenkins\_role\_arn](#output\_jenkins\_role\_arn) | AWS IAM Role ARN |
| <a name="output_launch_configuration"></a> [launch\_configuration](#output\_launch\_configuration) | AWS EC2 Launch Configuration |
| <a name="output_loadbalancer_arn"></a> [loadbalancer\_arn](#output\_loadbalancer\_arn) | LoadBalancer Arn |
| <a name="output_loadbalancer_dns_name"></a> [loadbalancer\_dns\_name](#output\_loadbalancer\_dns\_name) | LoadBalancer DNS Name |
| <a name="output_user_data"></a> [user\_data](#output\_user\_data) | User Data |
