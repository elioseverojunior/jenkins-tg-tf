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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_all_subnets"></a> [all\_subnets](#module\_all\_subnets) | ./modules//subnets/ | n/a |
| <a name="module_private_subnets"></a> [private\_subnets](#module\_private\_subnets) | ./modules//subnets/ | n/a |
| <a name="module_public_subnets"></a> [public\_subnets](#module\_public\_subnets) | ./modules//subnets/ | n/a |
| <a name="module_subnets"></a> [subnets](#module\_subnets) | ./modules//subnets/ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.efs_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.jenkins_agent_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.jenkins_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.lb_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.lb_to_tg_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.all_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.all_private_by_filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet_ids.all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_subnet_ids.all_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_subnet_ids.all_private_by_filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_subnet_ids.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.vpc_info](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_cidr_blocks"></a> [access\_cidr\_blocks](#input\_access\_cidr\_blocks) | Access CIDR Blocks | `list(string)` | `[]` | no |
| <a name="input_additional_security_groups"></a> [additional\_security\_groups](#input\_additional\_security\_groups) | Additional Security Groups Id's | `list(string)` | `[]` | no |
| <a name="input_additional_whitelisted_cidr_blocks"></a> [additional\_whitelisted\_cidr\_blocks](#input\_additional\_whitelisted\_cidr\_blocks) | description | `list(string)` | `[]` | no |
| <a name="input_all_private_subnet_tag_filter"></a> [all\_private\_subnet\_tag\_filter](#input\_all\_private\_subnet\_tag\_filter) | Tag to be filter in subnets | `map(any)` | <pre>{<br>  "Name": "*private*"<br>}</pre> | no |
| <a name="input_application"></a> [application](#input\_application) | Application Name | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_cidr_block_filter"></a> [cidr\_block\_filter](#input\_cidr\_block\_filter) | Used To filter CIDR's Blocks | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_corp_whitelisted_cidr_blocks"></a> [corp\_whitelisted\_cidr\_blocks](#input\_corp\_whitelisted\_cidr\_blocks) | description | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment Name | `string` | n/a | yes |
| <a name="input_jnlp_port"></a> [jnlp\_port](#input\_jnlp\_port) | n/a | `number` | `50000` | no |
| <a name="input_lambda_cidr_block_filter"></a> [lambda\_cidr\_block\_filter](#input\_lambda\_cidr\_block\_filter) | Used To filter CIDR's Blocks | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_lambda_subnet_tag_filter"></a> [lambda\_subnet\_tag\_filter](#input\_lambda\_subnet\_tag\_filter) | Tag to be filter in subnets | `map(any)` | <pre>{<br>  "Name": "*private*",<br>  "lambda": "yes"<br>}</pre> | no |
| <a name="input_public_subnet_tag_filter"></a> [public\_subnet\_tag\_filter](#input\_public\_subnet\_tag\_filter) | Tag to be filter in subnets | `map(any)` | <pre>{<br>  "Name": "*public*"<br>}</pre> | no |
| <a name="input_selected_subnets"></a> [selected\_subnets](#input\_selected\_subnets) | description | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | AWS Tags Standards | `map(string)` | <pre>{<br>  "ansible": false,<br>  "deployer": "TBD",<br>  "iac": "terraform",<br>  "owner": "SRE",<br>  "project": "TBD",<br>  "region": "TBD",<br>  "repo": "https://github.com/PasseiDireto/terraform-jenkins-iac.git",<br>  "stack": "TBD",<br>  "tier": "infra"<br>}</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | AWS VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_cidr_blocks"></a> [all\_cidr\_blocks](#output\_all\_cidr\_blocks) | All Subnets CIDR Blocks |
| <a name="output_all_subnets_ids"></a> [all\_subnets\_ids](#output\_all\_subnets\_ids) | All Subnets IDs |
| <a name="output_all_subnets_map"></a> [all\_subnets\_map](#output\_all\_subnets\_map) | All Subnets |
| <a name="output_private_cidr_blocks"></a> [private\_cidr\_blocks](#output\_private\_cidr\_blocks) | Private Subnets CIDR Blocks |
| <a name="output_private_subnets_ids"></a> [private\_subnets\_ids](#output\_private\_subnets\_ids) | Private Subnets IDs |
| <a name="output_private_subnets_map"></a> [private\_subnets\_map](#output\_private\_subnets\_map) | Private Subnets |
| <a name="output_public_cidr_blocks"></a> [public\_cidr\_blocks](#output\_public\_cidr\_blocks) | Public Subnets CIDR Blocks |
| <a name="output_public_subnets_ids"></a> [public\_subnets\_ids](#output\_public\_subnets\_ids) | Public Subnets IDs |
| <a name="output_public_subnets_map"></a> [public\_subnets\_map](#output\_public\_subnets\_map) | Public Subnets |
| <a name="output_security_group_efs_id"></a> [security\_group\_efs\_id](#output\_security\_group\_efs\_id) | EFS Security Group Id |
| <a name="output_security_group_jenkins_agent_id"></a> [security\_group\_jenkins\_agent\_id](#output\_security\_group\_jenkins\_agent\_id) | Jenkins Agent Security Group Id |
| <a name="output_security_group_jenkins_id"></a> [security\_group\_jenkins\_id](#output\_security\_group\_jenkins\_id) | Jenkins Security Group Id |
| <a name="output_security_group_loadbalancer_id"></a> [security\_group\_loadbalancer\_id](#output\_security\_group\_loadbalancer\_id) | LoadBalancer Security Group Id |
| <a name="output_selected_subnets_cidr_blocks"></a> [selected\_subnets\_cidr\_blocks](#output\_selected\_subnets\_cidr\_blocks) | AWS Subnets Id |
| <a name="output_selected_subnets_ids"></a> [selected\_subnets\_ids](#output\_selected\_subnets\_ids) | AWS Subnets Ids |
| <a name="output_selected_subnets_map"></a> [selected\_subnets\_map](#output\_selected\_subnets\_map) | AWS Subnets Map |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | AWS VPC ID |
