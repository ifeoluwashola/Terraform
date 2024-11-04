variable "lb_name" {
  description = "The name of the ALB"
  type        = string
}

variable "subnets" {
  description = "The subnets to attach to the ALB"
  type        = list(string)
}

variable "lb_type" {
  description = "The type of the Load Balancer (application, network)"
  type        = string
  default     = "application"
}

variable "security_groups" {
  description = "The security groups to attach to the ALB"
  type        = list(string)
}

variable "listener_port" {
  description = "The port on which the listener is created"
  type        = number
}

variable "listener_protocol" {
  description = "The protocol for the listener (HTTP, HTTPS)"
  type        = string
}

variable "target_group_arn" {
  description = "The target group ARN to forward requests to"
  type        = string
}
