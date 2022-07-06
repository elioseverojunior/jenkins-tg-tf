locals {
  subnets = {
    for subnet in var.subnets :
    (length(regexall("private", lookup(subnet.tags, "Name", ""))) > 0
      ? format("%s_%s", lookup(subnet.tags, "Name", ""), subnet.availability_zone)
    : format("%s_%s", lookup(subnet.tags, "Name", ""), subnet.availability_zone))
    => {
      availability_zone = subnet.availability_zone
      cidr_block        = subnet.cidr_block
      id                = subnet.id
    }
  }
  ids         = sort(flatten([for subnet in local.subnets : subnet.id]))
  cidr_blocks = sort(flatten([for subnet in local.subnets : subnet.cidr_block]))
  selected_subnets = {
    for subnet in var.subnets :
    (length(regexall("private", lookup(subnet.tags, "Name", ""))) > 0
      ? format("%s_%s", lookup(subnet.tags, "Name", ""), subnet.availability_zone)
    : format("%s_%s", lookup(subnet.tags, "Name", ""), subnet.availability_zone))
    => {
      availability_zone = subnet.availability_zone
      cidr_block        = subnet.cidr_block
      id                = subnet.id
    } if contains(var.selected_subnets, subnet.id)
  }
  selected_ids         = sort(flatten([for subnet in local.selected_subnets : subnet.id if contains(var.selected_subnets, subnet.id)]))
  selected_cidr_blocks = sort(flatten([for subnet in local.selected_subnets : subnet.cidr_block if contains(var.selected_subnets, subnet.id)]))
}