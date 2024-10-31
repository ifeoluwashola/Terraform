include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules//ecs-service"
}

dependencies {
  paths = [
    "../ecs-cluster",
    "../ecs-task",
    "../alb-target-group",
    "../security-groups"
  ]
}

inputs = {
  service_name         = "ecs-service"
  desired_count        = 0
  cluster_id           = dependency.ecs-cluster.outputs.cluster_id
  task_definition_arn  = dependency.ecs-task.outputs.task_definition_arn
  subnets              = dependency.network.outputs.subnets
  security_groups      = dependency.security-groups.outputs.security_group_ids
  target_group_arn     = dependency.alb-target-group.outputs.target_group_arn
  container_name       = "app"
  container_port       = 80
}
