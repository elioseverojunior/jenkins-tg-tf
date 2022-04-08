resource "aws_datasync_location_efs" "source" {
  efs_file_system_arn = data.aws_efs_file_system.source.arn
  subdirectory        = "/jenkins"

  ec2_config {
    security_group_arns = [for sg in toset(var.security_groups) : format("arn:aws:ec2:%s:%s:security-group/%s", var.aws_region, data.aws_caller_identity.current.account_id, sg)]
    subnet_arn          = format("arn:aws:ec2:%s:%s:subnet/%s", var.aws_region, data.aws_caller_identity.current.account_id, var.subnet_ids_source[0])
  }

  tags = merge(var.tags, { "Name" = format("%s-%s-location", var.environment, var.application) })
}

resource "aws_datasync_location_efs" "destination" {
  efs_file_system_arn = data.aws_efs_file_system.destination.arn
  subdirectory        = var.subdirectory

  ec2_config {
    security_group_arns = [for sg in toset(var.security_groups) : format("arn:aws:ec2:%s:%s:security-group/%s", var.aws_region, data.aws_caller_identity.current.account_id, sg)]
    subnet_arn          = format("arn:aws:ec2:%s:%s:subnet/%s", var.aws_region, data.aws_caller_identity.current.account_id, var.subnet_ids_destination[0])
  }

  tags = merge(var.tags, { "Name" = format("%s-%s-destination", var.environment, var.application) })
}

resource "aws_datasync_task" "task" {
  depends_on               = [aws_cloudwatch_log_group.this]
  destination_location_arn = aws_datasync_location_efs.destination.arn
  name                     = format("%s-%s-task", var.environment, var.application)
  source_location_arn      = aws_datasync_location_efs.source.arn
  cloudwatch_log_group_arn = aws_cloudwatch_log_group.this.arn

  options {
    bytes_per_second = -1
  }

  provisioner "local-exec" {
    command = "aws datasync update-task --task-arn ${self.arn} --options LogLevel=${var.cloudwatch_loglevel}"
  }

  tags = merge(var.tags, { "Name" = format("%s-%s-task", var.environment, var.application) })
}
