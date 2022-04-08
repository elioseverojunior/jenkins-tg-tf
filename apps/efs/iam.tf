resource "aws_iam_role" "efs_backup_role" {
  name = format("%s-backcup-role", local.prefix_name_lower)
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = [
            "backup.amazonaws.com",
          ]
        }
      },
    ]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"]
}

resource "aws_efs_file_system_policy" "efs_policy" {
  file_system_id = aws_efs_file_system.jenkins_efs.id
  policy         = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "${format("%sfilesystem", local.prefix_name_title)}",
    "Statement": [
        {
            "Sid": "${format("%sfilesystem", local.prefix_name_title)}",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Resource": "${aws_efs_file_system.jenkins_efs.arn}",
            "Action": [
                "elasticfilesystem:ClientMount",
                "elasticfilesystem:ClientWrite"
            ],
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "true"
                }
            }
        }
    ]
}
POLICY
}