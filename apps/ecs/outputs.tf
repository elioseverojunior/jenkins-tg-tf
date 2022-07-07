output "loadbalancer_arn" {
  description = "LoadBalancer Arn"
  value       = aws_lb.load_balancer.arn
}

output "loadbalancer_dns_name" {
  description = "LoadBalancer DNS Name"
  value       = format("http://%s", aws_lb.load_balancer.dns_name)
}

output "user_data" {
  description = "User Data"
  value       = data.template_file.cluster_user_data.rendered
  sensitive   = true
}

output "ecs_cluster_id" {
  description = "AWS ECS Cluster"
  value       = aws_ecs_cluster.jenkins_ecs.id
}

output "asg" {
  description = "AWS EC2 AutoScaling Group"
  value       = aws_autoscaling_group.asg.id
}

output "launch_configuration" {
  description = "AWS EC2 Launch Configuration"
  value       = aws_launch_configuration.lc.id
}

output "jenkins_execution_role_arn" {
  description = "AWS IAM Execution Role ARN"
  value       = aws_iam_role.jenkins_execution_role.arn
}
