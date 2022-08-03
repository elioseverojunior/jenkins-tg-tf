locals {
  cidr_blocks_all = sort(distinct(flatten([
    var.access_cidr_blocks_ipv4,
    var.additional_whitelisted_cidr_blocks_ipv4,
    var.aws_vpc_cidr_blocks_ipv4,
    var.corp_whitelisted_cidr_blocks_ipv4,
    var.github_webhooks_cidr_blocks_ipv4,
    module.subnets_all.cidr_blocks
  ])))

  cidr_blocks_private = sort(distinct(flatten([
    var.access_cidr_blocks_ipv4,
    var.additional_whitelisted_cidr_blocks_ipv4,
    var.aws_vpc_cidr_blocks_ipv4,
    var.corp_whitelisted_cidr_blocks_ipv4,
    var.github_webhooks_cidr_blocks_ipv4,
    module.subnets_private.cidr_blocks
  ])))

  cidr_blocks_public = sort(distinct(flatten([
    var.access_cidr_blocks_ipv4,
    var.additional_whitelisted_cidr_blocks_ipv4,
    var.aws_vpc_cidr_blocks_ipv4,
    var.corp_whitelisted_cidr_blocks_ipv4,
    var.github_webhooks_cidr_blocks_ipv4,
    module.subnets_public.cidr_blocks
  ])))

  selected_cidr_blocks = sort(distinct(flatten([
    var.access_cidr_blocks_ipv4,
    var.additional_whitelisted_cidr_blocks_ipv4,
    var.aws_vpc_cidr_blocks_ipv4,
    var.corp_whitelisted_cidr_blocks_ipv4,
    var.github_webhooks_cidr_blocks_ipv4,
    module.subnets.selected_cidr_blocks
  ])))
}
