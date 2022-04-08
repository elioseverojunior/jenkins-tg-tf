output "all_subnets_map" {
  description = "All Subnets"
  value       = module.all_subnets.subnets
}

output "all_subnets_ids" {
  description = "All Subnets IDs"
  value       = module.all_subnets.ids
}

output "private_subnets_map" {
  description = "Private Subnets"
  value       = module.private_subnets.subnets
}

output "private_subnets_ids" {
  description = "Private Subnets IDs"
  value       = module.private_subnets.ids
}

output "public_subnets_map" {
  description = "Public Subnets"
  value       = module.public_subnets.subnets
}

output "public_subnets_ids" {
  description = "Public Subnets IDs"
  value       = module.public_subnets.ids
}

output "all_cidr_blocks" {
  description = "All Subnets CIDR Blocks"
  value       = local.all_cidr_blocks
}

output "private_cidr_blocks" {
  description = "Private Subnets CIDR Blocks"
  value       = local.private_cidr_blocks
}

output "public_cidr_blocks" {
  description = "Public Subnets CIDR Blocks"
  value       = local.public_cidr_blocks
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
