variable "cluster_name" {
  description = "Name of the ECS Cluster"
  type        = string
}

variable "container_insights_enabled" {
  description = "Enable or disable container insights"
  type        = bool
  default     = true
}
