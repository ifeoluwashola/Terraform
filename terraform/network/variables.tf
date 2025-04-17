variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet"
}

variable "private_subnet_cidrs" {
  description = "Private subnet"
}

variable "availability_zones" {
  description = "Availability zones for the network"
}

variable "allowed_ssh_cidr" {
  description = "Your IP to allow SSH access"
}