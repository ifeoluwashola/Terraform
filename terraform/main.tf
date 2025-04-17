terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

module "network" {
  source               = "./network"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  allowed_ssh_cidr     = var.allowed_ssh_cidr
}

# module "rds" {
#   source             = "./rds"
#   vpc_id             = module.network.vpc_id
#   private_subnet_ids = module.network.private_subnet_ids
#   rds_sg_id          = module.network.rds_sg_id

#   db_password = var.db_password
# }

# module "ecr_ecs" {
#   source              = "./ecr_ecs"
#   app_name            = "django-app"
#   vpc_id              = module.network.vpc_id
#   public_subnet_ids   = module.network.public_subnet_ids
#   private_subnet_ids  = module.network.private_subnet_ids
#   ecs_sg_id           = module.network.ecs_sg_id
# }

# module "secrets" {
#   source = "./secrets"

#   app_name = "django-app"
#   secret_values = {
#     DJANGO_SECRET_KEY        = "supersecretkey"
#     DJANGO_DEBUG             = "False"
#     DB_NAME                  = module.rds.db_name
#     DB_USER                  = module.rds.db_username
#     DB_PASSWORD              = module.rds.db_password
#     DB_HOST                  = module.rds.db_host
#   }
# }
