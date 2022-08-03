resource "aws_iam_role" "ecs_instance_role" {
  name = format("%s-ecs-instance-role", local.prefix_name_lower)
  path = "/"

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
            "ec2.amazonaws.com",
            "s3.amazonaws.com",
          ]
        }
      },
    ]
  })
  tags = merge(var.tags, { Name = format("%s-ecs-instance-role", local.prefix_name_lower) })
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_attachment" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# Instance Profile
resource "aws_iam_instance_profile" "ecs_service_role" {
  depends_on = [
    aws_iam_role.ecs_instance_role
  ]
  name = format("%s-role-profile", local.prefix_name_lower)
  role = aws_iam_role.ecs_instance_role.name
  tags = merge(var.tags, { Name = format("%s-role-profile", local.prefix_name_lower) })
}

# Attach Policies to Instance Role
resource "aws_iam_policy_attachment" "amazon_ssm_managed_instance_core" {
  name       = format("%s-ssm-managed-instance-core", local.prefix_name_lower)
  roles      = sort(distinct(compact(flatten([aws_iam_role.jenkins_execution_role.id, aws_iam_role.ecs_instance_role.id, aws_iam_role.ecs_instance_role.id]))))
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_policy_attachment" "amazon_ec2_rolefor_ssm" {
  depends_on = [
    aws_iam_role.jenkins_execution_role,
    aws_iam_role.jenkins_role
  ]
  name       = format("%s-amazon-ec2-rolefor-ssm", local.prefix_name_lower)
  roles      = sort(distinct(compact(flatten([aws_iam_role.jenkins_execution_role.id, aws_iam_role.ecs_instance_role.id, aws_iam_role.ecs_instance_role.id]))))
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
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
  tags                = merge(var.tags, { Name = format("%s-ecs-instance-role", local.prefix_name_lower) })
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
