# # Root Terragrunt configuration for all environments
# locals {
#   project_name = "my-ecs-project"
#   # Add any global variables or configurations here
# }

# # Define the S3 backend bucket and DynamoDB table globally for all environments
# remote_state {
#   backend = "s3"
#   config = {
#     bucket         = "ecs-tf-bucket-us"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "ecs-tf.state-lock"
#     # Note: `key` is not specified here because it's set at the environment level
#   }
# }

# # Backend and provider configurations will be inherited by all child terragrunt.hcl files
# generate "backend" {
#   path      = "backend.tf"
#   if_exists = "overwrite_terragrunt"
#   contents = <<EOF
# terraform {
#   backend "s3" {
#     bucket         = "ecs-tf-bucket-us"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "ecs-tf.state-lock"
#   }
# }
# EOF
# }

# # Include this root configuration in all environment-specific terragrunt.hcl files
# include "root" {
#   path = find_in_parent_folders()
# }
