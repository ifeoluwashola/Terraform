variable "vpc_id" {
  description = "The ID of the VPC for the security group"
  type        = string
}

variable "lb_sg_name" {
  description = "The name of the security group for the Load Balancer"
  type        = string
}

variable "ecs_tasks_sg_name" {
  description = "The name of the security group for the ECS tasks"
  type        = string
}
