variable "role_name" {
  description = "Name of the ECS Task Execution Role"
  type        = string
}

variable "policy_arn" {
  description = "Policy ARN to attach to the ECS Task Execution Role"
  type        = string
}
