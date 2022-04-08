variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "application" {
  description = "Application Name"
  type        = string
}

variable "ecr_name" {
  description = "AWS ECR Registry Name"
  type        = string
}

variable "tags" {
  description = "AWS Tags"
  type        = map(any)
}

variable "vpc_id" {
  description = "AWS VPC Id"
  type        = string
}

variable "enable_ecr_image_tag_mutability" {
  type    = bool
  default = false
}

variable "ecr_encryption_type" {
  type    = string
  default = "AES256"
}

variable "ecr_scan_on_push" {
  type    = bool
  default = true
}
