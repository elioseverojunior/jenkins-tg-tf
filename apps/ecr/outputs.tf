output "ecr" {
  description = "AWS ECR Registry Info"
  value       = aws_ecr_repository.registry
}

output "ecr_id" {
  description = "AWS ECR Registry Id"
  value       = aws_ecr_repository.registry.id
}

output "ecr_url" {
  description = "AWS ECR Repository Url"
  value       = aws_ecr_repository.registry.repository_url
}