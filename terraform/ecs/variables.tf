variable "app_name" {
  default = "django-app"
}

variable "vpc_id" {}
variable "private_subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "ecs_sg_id" {}
