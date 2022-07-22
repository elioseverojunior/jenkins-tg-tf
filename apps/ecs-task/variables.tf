variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "application" {
  description = "Application Name"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "certificate_arn" {
  type    = string
  default = ""
}

/*
    EFS
*/
variable "efs_file_system_id" {
  description = "EFS Filesystem ID"
  type        = string
}

variable "efs_access_point_id" {
  description = "EFS Access Point ID"
  type        = string
}

variable "efs_mount_point" {
  description = "EFS Mounting Point in EC2"
  type        = string
}

variable "efs_root_directory_path" {
  description = "EFS Mounting Point in EC2"
  type        = string
  default     = ""
}

/*
    ECS
*/
variable "ecs_cluster_id" {
  description = "AWS ECS Cluster ID"
  type        = string
}

variable "loadbalancer_arn" {
  description = "AWS EC2 LoadBalancer ARN"
  type        = string
}

variable "jenkins_role_arn" {
  description = "AWS IAM Role ARN"
  type        = string
}

variable "jenkins_execution_role_arn" {
  description = "AWS IAM Execution Role ARN"
  type        = string
}

/*
    ECS Task Inputs
*/
variable "image" {
  description = "Container Image"
  type        = string
}

variable "jnlp_port" {
  description = "Agent Port"
  type        = number
  default     = 50000
}

/*
    Security Group Inputs
*/
variable "additional_security_groups" {
  description = "Additional Security Groups Id's"
  type        = list(string)
  default     = []
}

variable "security_group_loadbalancer_id" {
  description = "LoadBalancer Security Groups ID"
  type        = string
}

variable "security_group_jenkins_id" {
  description = "Jenkins Security Groups ID"
  type        = string
}

variable "security_group_jenkins_agent_id" {
  description = "Jenkins Agent Security Group ID"
  type        = string
}

variable "security_group_efs_id" {
  description = "EFS Security Group ID"
  type        = string
}

/*
    VPC Inputs
*/
variable "cidr_blocks_all" {
  description = "All Subnets CIDR Blocks"
  type        = list(string)
}

variable "cidr_blocks_private" {
  description = "Private Subnets CIDR Blocks"
  type        = list(string)
}

variable "cidr_blocks_public" {
  description = "Public Subnets CIDR Blocks"
  type        = list(string)
}

variable "selected_subnet_cidr_blocks" {
  description = "Selected Subnets CIDR Blocks"
  type        = list(string)
  default     = []
}

variable "subnets_all_ids" {
  description = "All Subnets IDs"
  type        = list(string)
}

variable "subnets_private_ids" {
  description = "Private Subnets IDs"
  type        = list(string)
}

variable "subnets_public_ids" {
  description = "Public Subnets IDs"
  type        = list(string)
}

variable "selected_subnets_ids" {
  description = "Selected Subnets IDs"
  type        = list(string)
  default     = []
}

variable "subnets_all_map" {
  description = "All Subnets"
  type = map(object({
    availability_zone = string
    cidr_block        = string
    id                = string
  }))
}

variable "subnets_private_map" {
  description = "Private Subnets"
  type = map(object({
    availability_zone = string
    cidr_block        = string
    id                = string
  }))
}

variable "subnets_public_map" {
  description = "Public Subnets"
  type = map(object({
    availability_zone = string
    cidr_block        = string
    id                = string
  }))
}

variable "selected_subnets_map" {
  description = "Selected Subnets Map"
  type = map(object({
    availability_zone = string
    cidr_block        = string
    id                = string
  }))
  default = {}
}

variable "vpc_id" {
  description = "AWS VPC ID"
  type        = string
}

/*
    CloudWatch
*/
variable "cloud_watch_retention_in_days" {
  description = "AWS Cloud Watch Retention Period in Days"
  type        = number
  default     = 7
}

/*
    TAGS
*/
variable "tags" {
  description = "description"
  type        = map(string)
  default = {
    "ansible"  = false
    "deployer" = "TBD"
    "iac"      = "terraform"
    "owner"    = "SRE"
    "project"  = "TBD"
    "region"   = "TBD"
    "repo"     = "https://github.com/Agrium/tf-jenkins-br.git"
    "stack"    = "TBD"
    "tier"     = "infra"
  }
}
