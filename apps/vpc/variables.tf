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

variable "vpc_id" {
  description = "AWS VPC ID"
  type        = string
}

variable "public_subnet_tag_filter" {
  description = "Tag to be filter in subnets"
  type        = map(any)

  default = {
    Name = "*public*"
  }
}

variable "all_private_subnet_tag_filter" {
  description = "Tag to be filter in subnets"
  type        = map(any)

  default = {
    Name = "*private*"
  }
}

variable "lambda_subnet_tag_filter" {
  description = "Tag to be filter in subnets"
  type        = map(any)
  default = {
    Name   = "*private*"
    lambda = "yes"
  }
}

variable "lambda_cidr_block_filter" {
  description = "Used To filter CIDR's Blocks"
  type        = list(string)
  default     = ["*"]
}

variable "cidr_block_filter" {
  description = "Used To filter CIDR's Blocks"
  type        = list(string)
  default     = ["*"]
}

variable "additional_security_groups" {
  description = "Additional Security Groups Id's"
  type        = list(string)
  default     = []
}

variable "access_cidr_blocks_ipv4" {
  description = "Access CIDR Blocks"
  type        = list(string)
  default = [
    "191.13.225.219/32"
  ]
}

variable "additional_whitelisted_cidr_blocks_ipv4" {
  description = "description"
  type        = list(string)
  default     = []
}

variable "aws_vpc_cidr_blocks_ipv4" {
  description = "description"
  type        = list(string)
  default     = []
}

variable "corp_whitelisted_cidr_blocks_ipv4" {
  description = "description"
  type        = list(string)
  default = [
    "10.0.0.0/8"
  ]
}

variable "github_webhooks_cidr_blocks_ipv4" {
  description = "description"
  type        = list(string)
  default = [
    "192.30.252.0/22",
    "185.199.108.0/22",
    "140.82.112.0/20",
    "143.55.64.0/20",
  ]
}

variable "selected_subnets" {
  description = "description"
  type        = list(string)
  default     = []
}

/*
    Ports
*/
variable "jnlp_port" {
  type    = number
  default = 50000
}

/*
    TAGS
*/
variable "tags" {
  description = "AWS Tags Standards"
  type        = map(string)
  default     = {}
}
