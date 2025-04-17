variable "db_name" {
  default = "ecommorce_db"
}

variable "db_username" {
  default = "ecommorce_user"
}

variable "db_password" {
  description = "RDS database password"
  sensitive   = true
}

variable "db_instance_class" {
  default = "db.t3.micro"
}

variable "vpc_id" {}
variable "private_subnet_ids" {
  type = list(string)
}
variable "rds_sg_id" {}
