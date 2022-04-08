output "account_id" {
  description = "AWS Account Id"
  value       = data.aws_caller_identity.current.account_id
}

output "datasync_role" {
  description = "AWS DataSync Role"
  value       = aws_iam_role.datasync_role
}

output "datasync_role_id" {
  description = "AWS DataSync Role Id"
  value       = aws_iam_role.datasync_role.id
}

output "datasync_role_policy" {
  description = "AWS DataSync Role Policy"
  value       = aws_iam_role_policy.datasync_policy
}

output "vpc_id" {
  description = "AWS VPC Id"
  value       = data.aws_vpc.this.id
}

output "file_system_source_data" {
  description = "AWS EFS Data"
  value       = data.aws_efs_file_system.source
}

output "file_system_source_id" {
  description = "AWS EFS Id"
  value       = data.aws_efs_file_system.source.id
}

output "file_system_source_dns_name" {
  description = "AWS EFS DNS Name"
  value       = data.aws_efs_file_system.source.dns_name
}

output "file_system_destination_data" {
  description = "AWS EFS Data"
  value       = data.aws_efs_file_system.destination
}

output "file_system_destination_id" {
  description = "AWS EFS Id"
  value       = data.aws_efs_file_system.destination.id
}

output "file_system_destination_dns_name" {
  description = "AWS EFS DNS Name"
  value       = data.aws_efs_file_system.destination.dns_name
}

output "datasync_source_location" {
  description = "AWS DataSync Source Location"
  value       = aws_datasync_location_efs.source
}

output "datasync_destination_location" {
  description = "AWS DataSync Destination Location"
  value       = aws_datasync_location_efs.destination
}

output "datasync_task" {
  description = "AWS DataSync Task"
  value       = aws_datasync_task.task
}
