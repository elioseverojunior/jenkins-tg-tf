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

variable "bucket_name" {
  description = "AWS S3 Bucket Name"
  type        = string
}

variable "vpc_id" {
  description = "AWS VPC Id"
  type        = string
}

variable "tags" {
  description = "AWS Tags"
  type        = map(any)
}

variable "subnet_ids_source" {
  description = "AWS Subnet Ids"
  type        = list(string)
}

variable "subnet_ids_destination" {
  description = "AWS Subnet Ids"
  type        = list(string)
}

variable "file_system_source_id" {
  description = "EFS Filesystem Source Id"
  type        = string
}

variable "file_system_destination_id" {
  description = "EFS Filesystem Destination Id"
  type        = string
}

variable "cloudwatch_loglevel" {
  description = "AWS CouldWatch Loglevel for DataSync. LogLevel: OFF, BASIC or TRANSFER (default is OFF)"
  type        = string
  default     = "OFF"
}

variable "security_groups" {
  description = "AWS Security Groups"
  type        = list(string)
}

variable "subdirectory" {
  description = "SubDirectory"
  type        = string
  default     = "/"
}

variable "cron" {
  description = "Cron Job"
  type        = string
  default     = "0 12PM ? * * *"
}
