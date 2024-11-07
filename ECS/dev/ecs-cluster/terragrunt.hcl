include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/ecs-cluster//"
}

inputs = {
  cluster_name = "ecs-cluster"
}
