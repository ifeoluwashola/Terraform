resource "aws_db_subnet_group" "django_rds_subnet_group" {
  name       = "django-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "django-rds-subnet-group"
  }
}

resource "aws_db_instance" "django_db" {
  identifier             = "django-db"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "14.10"
  instance_class         = var.db_instance_class
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.django_rds_subnet_group.name
  vpc_security_group_ids = [var.rds_sg_id]
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = false

  tags = {
    Name = "django-db"
  }
}
