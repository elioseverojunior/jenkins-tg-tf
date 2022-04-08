output "efs_id" {
  description = "AWS EFS Id"
  value       = aws_efs_file_system.jenkins_efs.id
}

output "efs_mounting_targets" {
  description = "AWS EFS Mounting Targets"
  value       = aws_efs_mount_target.jenkins_efs_mounting_targets
}

output "efs_access_point_id" {
  description = "AWS EFS Access Point"
  value       = aws_efs_access_point.jenkins_efs_ap.id
}
