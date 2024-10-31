include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules//alb-target-group"
}

dependencies {
  paths = [
    "../network"  # Assuming the VPC ID is output here
  ]
}

inputs = {
  target_group_name         = "alb-target-group"
  target_group_port         = 80
  target_group_protocol     = "HTTP"
  vpc_id                    = dependency.network.outputs.vpc_id
  target_type               = "ip"
  healthy_threshold         = 2
  health_check_interval     = 30
  health_check_protocol     = "HTTP"
  health_check_matcher      = "200"
  health_check_timeout      = 5
  health_check_path         = "/"
  unhealthy_threshold       = 2
}
