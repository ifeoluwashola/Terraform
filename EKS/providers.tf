provider "aws" {
  region = "eu-west-1"
}

provider "helm" {}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
