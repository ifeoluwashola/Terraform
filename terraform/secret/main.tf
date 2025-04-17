resource "aws_secretsmanager_secret" "django_env" {
  name = "${var.app_name}/env"
}

resource "aws_secretsmanager_secret_version" "django_env_version" {
  secret_id     = aws_secretsmanager_secret.django_env.id
  secret_string = jsonencode(var.secret_values)
}
