terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~>2.20.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "ecs-tf-bucket-us"
    key            = "env/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ecs-tf.state-lock"
    encrypt        = true
  }
}

provider "docker" {}

provider "aws" {
  region = var.aws_region
}

module "ecs_cluster" {
  source                  = "./modules/ecs-cluster"
  cluster_name            = var.ecs_cluster_name
  container_insights_enabled = true
}

module "ecs_task_definition" {
  source            = "./modules/ecs-task"
  family            = var.task_family
  execution_role_arn = module.ecs_task_execution_role.role_arn
  cpu               = var.task_cpu
  memory            = var.task_memory
  image             = var.task_image
  container_port    = var.container_port
  container_name    =  var.container_name
}

module "ecs_service" {
  source              = "./modules/ecs-service"
  service_name        = var.service_name
  cluster_id          = module.ecs_cluster.cluster_id
  task_definition_arn = module.ecs_task_definition.execution_role_arn
  subnets             = module.network.private_subnet_ids
  security_groups     = [module.network.ecs_tasks_sg_id]
  target_group_arn    = module.alb_target_group.target_group_arn
  container_name      = var.container_name
  container_port      = var.container_port
  desired_count       = var.desired_count
  dependency_list     = [
    module.ecs_task_execution_role,
    module.alb
  ]
}

module "ecs_task_execution_role" {
  source    = "./modules/ecs-task-execution-role"
  role_name = var.ecs_task_execution_role_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

module "ecs_task_role" {
  source    = "./modules/ecs-task-role"
  role_name = "ecsTaskRole"
}

module "alb" {
  source           = "./modules/alb"
  lb_name          = "alb"
  subnets          = module.network.public_subnet_ids
  security_groups  = [module.network.lb_sg_id]
  listener_port    = 80
  listener_protocol = "HTTP"
  target_group_arn = module.alb_target_group.target_group_arn
}

module "alb_target_group" {
  source                = "./modules/alb-target-group"
  target_group_name      = "alb-tg"
  target_group_port      = 80
  target_group_protocol  = "HTTP"
  vpc_id                = module.network.vpc_id
  healthy_threshold      = 3
  health_check_interval  = 90
  health_check_protocol  = "HTTP"
  health_check_matcher   = "200-299"
  health_check_timeout   = 20
  health_check_path      = var.health_check_path
  unhealthy_threshold    = 2
}

module "network" {
  source = "./modules/network"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  
  vpc_name                  = var.vpc_name
  igw_name                  = var.igw_name
  public_route_table_name   = var.public_route_table_name
  private_route_table_name  = var.private_route_table_name
  lb_sg_name                = var.lb_sg_name
  ecs_tasks_sg_name         = var.ecs_tasks_sg_name
}