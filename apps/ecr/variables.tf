variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment Name"
  type        = string
  default     = "nickel"
}

variable "application" {
  description = "Application Name"
  type        = string
  default     = "nutrien/jenkins"
}

variable "ecr_name" {
  description = "AWS ECR Registry Name"
  type        = string
  default     = "nutrien/jenkins"
}

variable "tags" {
  description = "AWS Tags"
  type        = map(any)
  default     = {}
}

variable "vpc_id" {
  description = "AWS VPC Id"
  type        = string
  default     = "vpc-0443d8f80bb165013"
}

variable "enable_ecr_image_tag_mutability" {
  type    = bool
  default = true
}

variable "ecr_encryption_type" {
  type    = string
  default = "AES256"
}

variable "ecr_scan_on_push" {
  type    = bool
  default = true
}
