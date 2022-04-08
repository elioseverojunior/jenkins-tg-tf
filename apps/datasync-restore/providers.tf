provider "aws" {
  region = var.aws_region

  default_tags {
    tags = merge(var.tags, { "Name" = format("%s-%s", var.environment, var.application), "project" = var.application, "region" = var.aws_region, "vpc_id" = var.vpc_id })
  }
}
