include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules//ecs-task"
}

dependency "ecs-task-execution-role" {
  config_path = "../ecs-task-execution-role"
}

inputs = {
  family          = "my-ecs-task"
  cpu             = 256
  memory          = 512
  image           = "nginx"
  container_name  = "nginx"
  container_port  = 80
  execution_role_arn = dependency.ecs-task-execution-role.outputs.execution_role_arn
}
