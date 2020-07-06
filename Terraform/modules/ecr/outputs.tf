output "reposiroty_url" {
  description = "ECR repository URL of Docker image"
  value       = aws_ecr_repository.ecr_repo.repository_url
}