locals {
  all_cidr_blocks = sort(distinct(flatten([
    var.access_cidr_blocks,
    var.additional_whitelisted_cidr_blocks,
    var.corp_whitelisted_cidr_blocks,
    module.all_subnets.cidr_blocks
  ])))

  private_cidr_blocks = sort(distinct(flatten([
    var.access_cidr_blocks,
    var.additional_whitelisted_cidr_blocks,
    var.corp_whitelisted_cidr_blocks,
    module.private_subnets.cidr_blocks
  ])))

  public_cidr_blocks = sort(distinct(flatten([
    var.access_cidr_blocks,
    var.additional_whitelisted_cidr_blocks,
    var.corp_whitelisted_cidr_blocks,
    module.public_subnets.cidr_blocks
  ])))

  selected_cidr_blocks = sort(distinct(flatten([
    var.access_cidr_blocks,
    var.additional_whitelisted_cidr_blocks,
    var.corp_whitelisted_cidr_blocks,
    module.subnets.selected_cidr_blocks
  ])))
}
