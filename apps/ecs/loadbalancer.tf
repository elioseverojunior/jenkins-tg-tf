resource "aws_lb" "load_balancer" {
  drop_invalid_header_fields = true
  enable_deletion_protection = false
  internal                   = var.enable_internal_load_balancer
  load_balancer_type         = "application"
  name                       = format("%s-alb", local.prefix_name_lower)
  security_groups            = sort(distinct(compact([var.security_group_loadbalancer_id])))
  subnets                    = length(var.selected_subnets_ids) > 0 ? var.selected_subnets_ids : var.subnets_public_ids
  tags                       = merge(var.tags, { Name = format("%s-alb", local.prefix_name_lower) })

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "hostedzone" {
  name         = "nickel.nutrien.digital."
  private_zone = true
}

resource "aws_route53_record" "record" {
  depends_on = [
    aws_lb.load_balancer,
  ]

  zone_id = data.aws_route53_zone.hostedzone.zone_id
  name    = "jenkins.nickel.nutrien.digital"
  type    = "CNAME"

  alias {
    name                   = aws_lb.load_balancer.dns_name
    zone_id                = aws_lb.load_balancer.zone_id
    evaluate_target_health = true
  }
}
