module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name = var.cluster_name
  compute_config = {
   enabled = false
  }

  kubernetes_version = "1.33"

  vpc_id = var.vpc_id
  subnet_ids = var.private_subnets

  enable_irsa = true
  endpoint_private_access = true
  endpoint_public_access = true

  enabled_log_types = ["api", "audit", "authenticator"]

  eks_managed_node_groups = {
    on_demand = {
      instance_types = ["t3.medium"]
      min_size       = 2
      max_size       = 4
      desired_size   = 3
      capacity_type  = "ON_DEMAND"
    }

    spot = {
      instance_types = ["t3.medium", "t3.large"]
      min_size       = 0
      max_size       = 3
      desired_size   = 1
      capacity_type  = "SPOT"
    }
  }

  tags = {
    Environment = "demo"
  }
}