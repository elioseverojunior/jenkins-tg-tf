resource "aws_efs_file_system" "jenkins_efs" {
  encrypted      = true
  creation_token = format("%s-filesystem", local.prefix_name_lower)
  tags           = merge(var.tags, { Name = local.prefix_name_lower })
}

resource "aws_efs_access_point" "jenkins_efs_ap" {
  depends_on = [
    aws_efs_file_system.jenkins_efs
  ]
  file_system_id = aws_efs_file_system.jenkins_efs.id
  posix_user {
    gid = "1000"
    uid = "1000"
  }
  root_directory {
    creation_info {
      owner_gid   = "1000"
      owner_uid   = "1000"
      permissions = "755"
    }
    path = var.efs_root_directory_path
  }
  tags = merge(var.tags, { Name = format("%s-access-point", local.prefix_name_lower) })
}

resource "aws_efs_mount_target" "jenkins_efs_mounting_targets" {
  depends_on = [
    aws_efs_file_system.jenkins_efs
  ]
  for_each        = length(var.selected_subnets_map) > 0 ? var.selected_subnets_map : var.subnets_private_map
  file_system_id  = aws_efs_file_system.jenkins_efs.id
  subnet_id       = each.value.id
  security_groups = local.efs_security_groups
}
