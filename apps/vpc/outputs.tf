output "subnets_all_map" {
  description = "All Subnets"
  value       = module.subnets_all.subnets
}

output "subnets_all_ids" {
  description = "All Subnets IDs"
  value       = sort(distinct(module.subnets_all.ids))
}

output "subnets_private_map" {
  description = "Private Subnets"
  value       = module.subnets_private.subnets
}

output "subnets_private_ids" {
  description = "Private Subnets IDs"
  value       = module.subnets_private.ids
}

output "subnets_public_map" {
  description = "Public Subnets"
  value       = module.subnets_public.subnets
}

output "subnets_public_ids" {
  description = "Public Subnets IDs"
  value       = module.subnets_public.ids
}

output "cidr_blocks_all" {
  description = "All Subnets CIDR Blocks"
  value       = local.cidr_blocks_all
}

output "cidr_blocks_private" {
  description = "Private Subnets CIDR Blocks"
  value       = local.cidr_blocks_private
}

output "cidr_blocks_public" {
  description = "Public Subnets CIDR Blocks"
  value       = local.cidr_blocks_public
}

output "selected_subnets_map" {
  description = "AWS Subnets Map"
  value       = module.subnets.selected_subnets
}

output "selected_subnets_cidr_blocks" {
  description = "AWS Subnets Id"
  value       = local.selected_cidr_blocks
}

output "selected_subnets_ids" {
  description = "AWS Subnets Ids"
  value       = module.subnets.selected_ids
}

output "vpc_id" {
  description = "AWS VPC ID"
  value       = var.vpc_id
}

/*
    Security Groups
*/
output "security_group_loadbalancer_id" {
  description = "LoadBalancer Security Group Id"
  value       = aws_security_group.lb_sg.id
}

output "security_group_jenkins_id" {
  description = "Jenkins Security Group Id"
  value       = aws_security_group.jenkins_sg.id
}

output "security_group_jenkins_agent_id" {
  description = "Jenkins Agent Security Group Id"
  value       = aws_security_group.jenkins_agent_sg.id
}

output "security_group_efs_id" {
  description = "EFS Security Group Id"
  value       = aws_security_group.efs_sg.id
}
