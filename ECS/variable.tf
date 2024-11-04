variable "aws_region" {
  description = "value of the region"
  default     = "us-east-1"
  type        = string
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "task_family" {
  description = "The family of the ECS task"
  type        = string
}

variable "task_memory" {
  description = "Memory for the ECS task"
  type        = number
}

variable "task_cpu" {
  description = "CPU units for the ECS task"
  type        = number
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "alb_listener_port" {
  description = "Port for the ALB listener"
  type        = number
}

variable "alb_listener_protocol" {
  description = "Protocol for the ALB listener"
  type        = string
}

variable "health_check_path" {
  description = "Health check path for the target group"
  type        = string
}

variable "desired_count" {
  description = "Desired count of ECS service tasks"
  type        = number
}

variable "ecs_task_role_name" {
  description = "Name of the ECS task role"
  type        = string
}

variable "ecs_task_execution_role_name" {
  description = "Name of the ECS task execution role"
  type        = string
}

variable "task_image" {
  description = "Docker image for the ECS task"
  type        = string
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "igw_name" {
  description = "Name tag for the Internet Gateway"
  type        = string
}

variable "public_route_table_name" {
  description = "Name tag for the public route table"
  type        = string
}

variable "private_route_table_name" {
  description = "Name tag for the private route table"
  type        = string
}

variable "lb_sg_name" {
  description = "Name for the load balancer security group"
  type        = string
}

variable "ecs_tasks_sg_name" {
  description = "Name for the ECS tasks security group"
  type        = string
}