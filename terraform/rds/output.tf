output "db_endpoint" {
  value = aws_db_instance.django_db.endpoint
}

output "db_username" {
  value = aws_db_instance.django_db.username
}

output "db_password" {
  value     = aws_db_instance.django_db.password
  sensitive = true
}

output "db_name" {
  value = aws_db_instance.django_db.name
}

output "db_host" {
  value = aws_db_instance.django_db.address
}