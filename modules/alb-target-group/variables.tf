variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "The port on which the target group listens"
  type        = number
}

variable "target_group_protocol" {
  description = "The protocol for the target group (HTTP, HTTPS)"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the target group resides"
  type        = string
}

variable "target_type" {
  description = "The type of target (instance, ip, lambda)"
  type        = string
  default     = "ip"
}

variable "healthy_threshold" {
  description = "The number of successful health checks before considering the target healthy"
  type        = number
}

variable "health_check_interval" {
  description = "The interval between health checks"
  type        = number
}

variable "health_check_protocol" {
  description = "The protocol for health checks (HTTP, HTTPS)"
  type        = string
}

variable "health_check_matcher" {
  description = "The matcher for health check success (HTTP status codes)"
  type        = string
}

variable "health_check_timeout" {
  description = "The timeout for health checks"
  type        = number
}

variable "health_check_path" {
  description = "The path for health checks"
  type        = string
}

variable "unhealthy_threshold" {
  description = "The number of failed health checks before considering the target unhealthy"
  type        = number
}
