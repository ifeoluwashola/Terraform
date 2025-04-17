output "ecr_repo_url" {
  value = aws_ecr_repository.django_repo.repository_url
}

output "alb_dns_name" {
  value = aws_lb.django_alb.dns_name
}
