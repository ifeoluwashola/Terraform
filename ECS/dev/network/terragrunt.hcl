include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/network//"
}

inputs = {
  vpc_cidr                 = "10.0.0.0/16"
  private_subnet_cidrs     = ["10.0.105.0/24"]
  public_subnet_cidrs      = ["10.0.101.0/24", "10.0.102.0/24"]
  availability_zones       = ["us-east-1a", "us-east-1b"]
  vpc_name                 = "ecs-main-vpc"
  igw_name                 = "main-igw"
  public_route_table_name  = "public-route-table"
  private_route_table_name = "private-route-table"
  lb_sg_name               = "lb-security-group"
  ecs_tasks_sg_name        = "ecs-tasks-security-group"
}
