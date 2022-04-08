
resource "aws_lb_target_group" "lb_tg" {
  name                 = format("%s-target-group", local.prefix_name_lower)
  port                 = 8080
  protocol             = "HTTP"
  target_type          = "instance"
  vpc_id               = var.vpc_id
  deregistration_delay = 1200
  slow_start           = 900

  health_check {
    enabled             = true
    healthy_threshold   = 10
    interval            = 120
    path                = "/login"
    unhealthy_threshold = 10
  }

  tags = merge(var.tags, { Name = format("%s-lb-tg", local.prefix_name_lower) })
}

resource "aws_lb_listener" "lb_listener" {
  for_each          = var.certificate_arn == "" || var.certificate_arn == null ? toset(["http"]) : toset([])
  load_balancer_arn = var.loadbalancer_arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }

  tags = merge(var.tags, { Name = format("%s-lb-http-listener", local.prefix_name_lower) })
}

resource "aws_lb_listener" "lb_listener_redirect" {
  for_each          = var.certificate_arn != "" && var.certificate_arn != null ? toset(["enabled"]) : toset([])
  load_balancer_arn = var.loadbalancer_arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = merge(var.tags, { Name = format("%s-lb-http-listener", local.prefix_name_lower) })
}

resource "aws_lb_listener" "lb_https_listener" {
  for_each          = var.certificate_arn != "" && var.certificate_arn != null ? toset(["enabled"]) : toset([])
  load_balancer_arn = var.loadbalancer_arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }

  tags = merge(var.tags, { Name = format("%s-lb-https-listener", local.prefix_name_lower) })
}
