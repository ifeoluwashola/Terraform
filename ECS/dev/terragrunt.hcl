# Environment-specific inputs
inputs = {
  aws_region = "us-east-1"
  # Define other global variables here if needed
}

# Environment-specific local values
locals {
  aws_region  = "us-east-1"
  environment = "dev"
}

# Generate provider configurations for AWS and Docker (if needed)
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~>2.20.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "docker" {}
EOF
}

remote_state {
  backend = "s3"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "ecs-tf-bucket-us"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "ecs-tf.state-lock"
    key            = "${path_relative_to_include()}/terraform.tfstate"
  }
}

# remote_state {
#   backend = "local"
#   generate = {
#     path = "backend.tf"
#     if_exists = "overwrite_terragrunt"
#   }
#   config = {
#     path = "${path_relative_to_include()}/terraform.tfstate"
#   }
# }