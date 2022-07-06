locals {
  cidr_blocks_all = sort(distinct(flatten([
    var.access_cidr_blocks,
    var.additional_whitelisted_cidr_blocks,
    var.corp_whitelisted_cidr_blocks,
    module.subnets_all.cidr_blocks
  ])))

  cidr_blocks_private = sort(distinct(flatten([
    var.access_cidr_blocks,
    var.additional_whitelisted_cidr_blocks,
    var.corp_whitelisted_cidr_blocks,
    module.subnets_private.cidr_blocks
  ])))

  cidr_blocks_public = sort(distinct(flatten([
    var.access_cidr_blocks,
    var.additional_whitelisted_cidr_blocks,
    var.corp_whitelisted_cidr_blocks,
    module.subnets_public.cidr_blocks
  ])))

  selected_cidr_blocks = sort(distinct(flatten([
    var.access_cidr_blocks,
    var.additional_whitelisted_cidr_blocks,
    var.corp_whitelisted_cidr_blocks,
    module.subnets.selected_cidr_blocks
  ])))
}
