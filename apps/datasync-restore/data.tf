data "aws_vpc" "this" {
  id = var.vpc_id
}

data "aws_efs_file_system" "source" {
  file_system_id = var.file_system_source_id
}

data "aws_efs_file_system" "destination" {
  file_system_id = var.file_system_destination_id
}
