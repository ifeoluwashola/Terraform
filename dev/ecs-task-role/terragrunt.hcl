include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules//ecs-task-role"
}

dependencies {
  paths = []
}

inputs = {
  role_name = "ecsTaskRole"
}
