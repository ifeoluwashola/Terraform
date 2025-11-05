variable "cluster_name" {
  type = string
  description = "EKS cluster name"
  default = "DEMO-EKS-CLSUTER"
}

variable "vpc_id" {
  type = string
  description = "The VPC ID where the EKS cluster will be deployed"
}

variable "private_subnets" {
  type = list(string)
  description = "A list of private subnet IDs for the EKS cluster"
}