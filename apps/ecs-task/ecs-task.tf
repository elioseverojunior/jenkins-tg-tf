resource "aws_ecs_task_definition" "jenkins_task_definition" {
  family                   = format("%s-task-definition", local.prefix_name_lower)
  task_role_arn            = var.jenkins_role_arn
  execution_role_arn       = var.jenkins_execution_role_arn
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]

  container_definitions = jsonencode([
    {
      name              = local.prefix_name_lower
      image             = var.image
      memoryReservation = 4096
      essential         = true
      environment = [
        {
          name  = "JAVA_OPTS"
          value = "-Duser.timezone=America/Sao_Paulo -Dhudson.security.HudsonPrivateSecurityRealm.ID_REGEX=[a-zA-Z0-9_.@-]+ -server -XX:+AlwaysPreTouch -Xms4096m -Xmx8192m"
        },
        {
          name  = "JENKINS_HOME"
          value = "/var/jenkins_home"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-create-group      = "true"
          awslogs-group             = format("%s-cw-log-group", local.prefix_name_lower)
          awslogs-multiline-pattern = "^INFO|^WARNING|^ERROR"
          awslogs-region            = var.aws_region
          awslogs-stream-prefix     = local.prefix_name_lower
        }
      }
      portMappings = [
        {
          containerPort = 8080
          protocol      = "tcp"
        },
        {
          containerPort = var.jnlp_port
          protocol      = "tcp"
        }
      ]
      mountPoints = [
        {
          sourceVolume  = local.prefix_name_lower
          containerPath = "/var/jenkins_home"
        }
      ]
    }
  ])

  volume {
    name = local.prefix_name_lower

    efs_volume_configuration {
      file_system_id     = var.efs_file_system_id
      transit_encryption = "ENABLED"
      root_directory     = format("%s%s", var.efs_mount_point, var.efs_root_directory_path)
      authorization_config {
        access_point_id = var.efs_access_point_id
        iam             = "DISABLED"
      }
    }
  }

  tags = merge(var.tags, { Name = format("%s-task-definition", local.prefix_name_lower) })
}

resource "aws_ecs_service" "jenkins_ecs_service" {
  name                               = format("%s-svc", local.prefix_name_lower)
  cluster                            = var.ecs_cluster_id
  task_definition                    = aws_ecs_task_definition.jenkins_task_definition.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  launch_type                        = "EC2"
  scheduling_strategy                = "REPLICA"

  load_balancer {
    target_group_arn = aws_lb_target_group.lb_tg.arn
    container_name   = local.prefix_name_lower
    container_port   = 8080
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  ordered_placement_strategy {
    field = "cpu"
    type  = "binpack"
  }

  ordered_placement_strategy {
    field = "memory"
    type  = "binpack"
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  tags           = merge(var.tags, { Name = format("%s-svc", local.prefix_name_lower) })
  propagate_tags = "TASK_DEFINITION"
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = format("%s-cw-log-group", local.prefix_name_lower)
  retention_in_days = var.cloud_watch_retention_in_days
  tags              = merge(var.tags, { Name = format("%s-cw-log-group", local.prefix_name_lower) })
}
