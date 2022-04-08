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

variable "efs_root_directory_path" {
  description = "EFS Mounting Point"
  type        = string
  default     = "/jenkins"
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
variable "all_cidr_blocks" {
  description = "All Subnets CIDR Blocks"
  type        = list(string)
}

variable "private_cidr_blocks" {
  description = "Private Subnets CIDR Blocks"
  type        = list(string)
}

variable "public_cidr_blocks" {
  description = "Public Subnets CIDR Blocks"
  type        = list(string)
}

variable "selected_subnet_cidr_blocks" {
  description = "Selected Subnets CIDR Blocks"
  type        = list(string)
  default     = []
}

variable "all_subnets_ids" {
  description = "All Subnets IDs"
  type        = list(string)
}

variable "private_subnets_ids" {
  description = "Private Subnets IDs"
  type        = list(string)
}

variable "public_subnets_ids" {
  description = "Public Subnets IDs"
  type        = list(string)
}

variable "selected_subnets_ids" {
  description = "Selected Subnets IDs"
  type        = list(string)
  default     = []
}

variable "all_subnets_map" {
  description = "All Subnets"
  type = map(object({
    availability_zone = string
    cidr_block        = string
    id                = string
  }))
}

variable "private_subnets_map" {
  description = "Private Subnets"
  type = map(object({
    availability_zone = string
    cidr_block        = string
    id                = string
  }))
}

variable "public_subnets_map" {
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
    TAGS
*/
variable "tags" {
  description = "AWS Tags Standards"
  type        = map(string)
  default = {
    "ansible"  = false
    "deployer" = "TBD"
    "iac"      = "terraform"
    "owner"    = "SRE"
    "project"  = "TBD"
    "region"   = "TBD"
    "repo"     = "https://github.com/PasseiDireto/terraform-jenkins-iac.git"
    "stack"    = "TBD"
    "tier"     = "infra"
  }
}
