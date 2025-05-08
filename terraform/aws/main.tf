module "vpc" {
  source = "./modules/vpc"
  prefix = var.prefix
}

module "eks" {
  source         = "./modules/eks"
  prefix         = var.prefix
  cluster_name   = var.cluster_name
  retention_days = var.retention_days
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.subnet_ids
  desired_size   = var.desired_size
  min_size       = var.min_size
  max_size       = var.max_size
}
