variable "environment" {
  type    = string
  default = "alpha"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "platformversion" {
  type    = string
  default = "3.0"
}

variable "project_name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "ip_cidr_range" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "service_account_name" {
  type = string
}

variable "cpu_max_cores" {
  type = number
}

variable "cpu_min_cores" {
  type = number
}

variable "memory_max" {
  type = number
}

variable "memory_min" {
  type = number
}

variable "preemptible" {
  type = bool
}

variable "backup_lock_days" {
  type = number
}

variable "backup_retain_days" {
  type = number
}

variable "pod_cidr_range" {
  type = string
}

variable "service_cidr_range" {
  type = string
}

variable "root_password" {
  type        = string
  sensitive   = true
  description = "value of the root password"
}

variable "min_node_count" {
  description = "Tradingbot Min Node Count"
  type        = number
}

variable "max_node_count" {
  description = "Tradingbot Max Node Count"
  type        = number
}

variable "machine_type" {
  description = "Tradingbot Machine Type"
  type        = string
}