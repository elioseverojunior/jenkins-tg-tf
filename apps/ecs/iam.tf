resource "aws_iam_role" "ecs_instance_role" {
  name = format("%s-ecs-instance-role", local.prefix_name_lower)
  path = "/"

  assume_role_policy = jsonencode({
    "Version" : "2008-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : sort([
            "ecs-tasks.amazonaws.com",
            "ec2.amazonaws.com",
            "ssm.amazonaws.com",
            "s3.amazonaws.com",
          ])
        },
        "Effect" : "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_ecs_instance_role" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_ssm_activation" "ssm_ecs_instance_role_activation" {
  name               = format("%s-ssm-activation", local.prefix_name_lower)
  description        = "SSM ${local.prefix_name_lower}"
  iam_role           = aws_iam_role.ecs_instance_role.id
  registration_limit = "5"
  depends_on         = [aws_iam_role_policy_attachment.ssm_ecs_instance_role]
  tags               = merge(var.tags, { Name = local.prefix_name_lower })
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_attachment" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_service_role" {
  name = format("%s-ecs-profile", local.prefix_name_lower)
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_iam_role" "jenkins_execution_role" {
  name = format("%s-execution-role", local.prefix_name_lower)
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = [
            "ecs-tasks.amazonaws.com",
          ]
        }
      },
    ]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
}

resource "aws_iam_role" "jenkins_role" {
  name = format("%s-role", local.prefix_name_lower)
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = [
            "ecs-tasks.amazonaws.com"
          ]
        }
      },
    ]
  })
  tags = merge(var.tags, { Name = format("%s-role", local.prefix_name_lower) })
}

resource "aws_iam_role_policy" "jenkins_policy" {
  name = format("%s-policy", local.prefix_name_lower)
  role = aws_iam_role.jenkins_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite",
          "elasticfilesystem:ClientRootAccess",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ecs:RegisterTaskDefinition",
          "ecs:ListClusters",
          "ecs:DescribeContainerInstances",
          "ecs:ListTaskDefinitions",
          "ecs:DescribeTaskDefinition",
          "ecs:DeregisterTaskDefinition",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "AllowPull",
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetAuthorizationToken",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetDownloadUrlForLayer",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ecs:ListContainerInstances",
          "ecs:RunTask",
          "ecs:StopTask",
          "ecs:DescribeTasks",
          "iam:GetRole",
          "iam:PassRole"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy" "ecs_instance_role_policy" {
  name = format("%s-policy", local.prefix_name_lower)
  role = aws_iam_role.ecs_instance_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite",
          "elasticfilesystem:ClientRootAccess",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ecs:RegisterTaskDefinition",
          "ecs:ListClusters",
          "ecs:DescribeContainerInstances",
          "ecs:ListTaskDefinitions",
          "ecs:DescribeTaskDefinition",
          "ecs:DeregisterTaskDefinition",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "AllowPull",
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetAuthorizationToken",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetDownloadUrlForLayer",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ecs:ListContainerInstances",
          "ecs:RunTask",
          "ecs:StopTask",
          "ecs:DescribeTasks",
          "iam:GetRole",
          "iam:PassRole"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy" "jenkins_execution_role_policy" {
  name = format("%s-policy", local.prefix_name_lower)
  role = aws_iam_role.jenkins_execution_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite",
          "elasticfilesystem:ClientRootAccess",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ecs:RegisterTaskDefinition",
          "ecs:ListClusters",
          "ecs:DescribeContainerInstances",
          "ecs:ListTaskDefinitions",
          "ecs:DescribeTaskDefinition",
          "ecs:DeregisterTaskDefinition",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "AllowPull",
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetAuthorizationToken",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetDownloadUrlForLayer",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ecs:ListContainerInstances",
          "ecs:RunTask",
          "ecs:StopTask",
          "ecs:DescribeTasks",
          "iam:GetRole",
          "iam:PassRole"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "ssm_iam_instance_profile_role" {
  name = format("%s-asg-ssm-profile", local.prefix_name_lower)
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

# resource "aws_iam_instance_profile" "ssm_iam_instance_profile" {
#   depends_on = [
#     aws_iam_role.ssm_iam_instance_profile_role
#   ]
#   name = format("%s-asg-ssm-profile", local.prefix_name_lower)
#   role = aws_iam_role.ssm_iam_instance_profile_role.name
# }

/* resource "aws_ssm_activation" "ssm_iam_instance_profile_activation" {
  name               = format("%s-ssm-iam-instance-profile-activation", local.prefix_name_lower)
  description        = "SSM ${local.prefix_name_lower}"
  iam_role           = aws_iam_role.ssm_iam_instance_profile_role.id
  registration_limit = "10"
  tags               = merge(var.tags, { Name = local.prefix_name_lower })
} */
