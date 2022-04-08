data "aws_caller_identity" "current" {}

resource "aws_iam_role" "datasync_role" {
  name = format("%s-%s-role", var.environment, var.application)

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "" #format("%s%sRole", title(var.environment), title(var.application))
        Principal = {
          Service : [
            "datasync.amazonaws.com",
            "s3.amazonaws.com"
          ]
        }
      },
    ]
  })
  tags = merge(var.tags, { "Name" = format("%s-%s-role", var.environment, var.application) })
}

resource "aws_iam_role_policy" "datasync_policy" {
  name = format("%s-%s-policy", var.environment, var.application)
  role = aws_iam_role.datasync_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
          "efs:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
