output "secret_arn" {
  value = aws_secretsmanager_secret.django_env.arn
}
