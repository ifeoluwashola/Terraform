include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/ecs-task-execution-role//"
}

inputs = {
  role_name = "ecs-execution-role"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
