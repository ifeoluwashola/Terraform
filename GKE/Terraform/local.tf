####################################
# Variables that are used for all resources
####################################

locals {
  resource_name_suffix = "${var.environment}-${var.region}"
  resource_labels = {
    "environment"      = var.environment
    "region"           = var.region
    "platform-version" = var.platformversion
  }
}
