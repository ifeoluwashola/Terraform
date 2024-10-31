include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules//security-groups"
}

dependencies {
  paths = [
    "../network"
  ]
}

inputs = {
  lb_sg_name        = "ecs-lb-sg"
  ecs_tasks_sg_name = "ecs-tasks-sg"
}