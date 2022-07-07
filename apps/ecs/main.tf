resource "aws_ecs_cluster" "jenkins_ecs" {
  name = local.prefix_name_lower

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = merge(var.tags, { Name = local.prefix_name_lower })
}
