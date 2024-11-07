include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/ecs-service//"
}

dependency "network" {
  config_path = "../network"
}

dependency "security-groups" {
  config_path = "../security-groups"
}

dependency "alb-target-group" {
  config_path = "../alb-target-group"
}

dependency "ecs-task" {
  config_path = "../ecs-task"
}

dependency "ecs-cluster" {
  config_path = "../ecs-cluster"
}

inputs = {
  service_name         = "ecs-service"
  desired_count        = 0
  cluster_id           = dependency.ecs-cluster.outputs.cluster_id
  task_definition_arn  = dependency.ecs-task.outputs.task_definition_arn
  subnets              = dependency.network.outputs.private_subnet_ids
  security_groups      = [ dependency.security-groups.outputs.ecs_tasks_sg_id ]
  target_group_arn     = dependency.alb-target-group.outputs.target_group_arn
  container_name       = "nginx"
  container_port       = 80
}
