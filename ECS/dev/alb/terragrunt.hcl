include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules//alb"
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

inputs = {
  lb_name              = "alb"
  listener_port     = 80
  listener_protocol = "HTTP"
  subnets               = dependency.network.outputs.public_subnet_ids             
  security_groups       = [ dependency.security-groups.outputs.lb_sg_id ]   
  target_group_arn      = dependency.alb-target-group.outputs.target_group_arn
}
