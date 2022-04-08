resource "aws_lb" "load_balancer" {
  name               = format("%s-alb", local.prefix_name_lower)
  internal           = var.enable_internal_load_balancer
  load_balancer_type = "application"
  security_groups    = [var.security_group_loadbalancer_id]
  subnets            = length(var.selected_subnets_ids) > 0 ? var.selected_subnets_ids : var.public_subnets_ids
  tags               = merge(var.tags, { Name = format("%s-alb", local.prefix_name_lower) })
}
