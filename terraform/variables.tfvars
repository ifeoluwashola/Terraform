region               = "eu-west-2"
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones   = ["eu-west-2a", "eu-west-2b"]
allowed_ssh_cidr     = "102.89.82.84/32"
db_password          = "ecommerce_db_passwd"
secret_values = {
  DJANGO_SECRET_KEY = "django-insecure-%#glg4fdwzoh_u2e9-wkwli45+&m!foy3su7lm5zxohibah2#^"
  DJANGO_DEBUG      = "False"
  DB_NAME           = "ecommerce_db"
  DB_USER           = "ecommerce_user"
  DB_PASSWORD       = "ecommerce_db_passwd"
  DB_HOST           = "db-instance-name.rds.amazonaws.com"
  ALLOWED_HOSTS     = "localhost,127.0.0.1"
}