include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules//alb"
}

# dependencies {
#   paths = [
#     "../network",
#     "../security-groups",
#     "../alb-target-group"  # Assuming target group is defined here
#   ]
# }

dependency "network" {
  config_path = "../network"
}

dependency "security-groups" {
  config_path = "../security-groups"
}

dependency "alb-target-group" {
  config_path = "../alb-target-group"
}

inputs = {
  alb_name              = "alb"
  alb_listener_port     = 80
  alb_listener_protocol = "HTTP"
  subnets               = dependency.network.outputs.subnets             # From network module
  security_groups       = dependency.security-groups.outputs.sg_ids      # From security-groups module
  target_group_arn      = dependency.alb-target-group.outputs.target_group_arn
}
