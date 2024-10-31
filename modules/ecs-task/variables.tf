variable "family" {
  description = "Name of the task definition family"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN of the task execution role"
  type        = string
}

variable "cpu" {
  description = "CPU units to allocate to the task"
  type        = number
}

variable "memory" {
  description = "Memory (MB) to allocate to the task"
  type        = number
}

variable "image" {
  description = "Container image"
  type        = string
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "container_port" {
  description = "Port to expose from the container"
  type        = number
}
