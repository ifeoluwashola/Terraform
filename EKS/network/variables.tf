variable "vpc_cidr" {
  type = string
  description = "The cidr block for VPC"
  default = "10.0.0.0/16"
}

variable "private_subnet_cidr" {
  type = list(string)
  description = "The cidr range for private subnet"
  default = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
}

variable "public_subnet_cidr" {
  type = list(string)
  description = "The cidr range for public subnet"
  default = [ "10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24" ]
}

variable "vpc_azs" {
  type = list(string)
  description = "The availability zones for VPC"
  default = [ "eu-west-1a", "eu-west-1b", "eu-west-1c" ]
}

variable "vpc_name" {
  type = string
  description = "The name for VPC"
  default = "EKS-VPC"
}

variable "tags" {
  type = map(string)
  description = "A map of tags to add to all resources"
  default = {
      Terraform   = "true"
      Environment = "demo"
      project     = "EKS"
  }
}