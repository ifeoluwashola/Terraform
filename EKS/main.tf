module "network" {
  source = "./network"
}

module "eks" {
  source = "./eks"

  vpc_id          = module.network.vpc_id
  private_subnets = module.network.private_subnets
}
