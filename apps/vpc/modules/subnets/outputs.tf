output "cidr_blocks" {
  description = "AWS Subnets Id"
  value       = local.cidr_blocks
}

output "ids" {
  description = "AWS Subnets Ids"
  value       = local.ids
}

output "subnets" {
  description = "AWS Subnets Map"
  value       = local.subnets
}

output "selected_cidr_blocks" {
  description = "AWS Subnets Id"
  value       = local.selected_cidr_blocks
}

output "selected_ids" {
  description = "AWS Subnets Ids"
  value       = local.selected_ids
}

output "selected_subnets" {
  description = "AWS Subnets Map"
  value       = local.selected_subnets
}
