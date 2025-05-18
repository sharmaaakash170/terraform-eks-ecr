###################
# VPC Module
###################

module "vpc" {
  source               = "../../modules/vpc"
  azs                  = var.azs
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  project_name         = var.project_name
}

###################
# IAM Module
###################

module "iam" {
  source       = "../../modules/iam"
  cluster_name = var.cluster_name
}

###################
# ECR Module
###################

module "ecr" {
  source       = "../../modules/ecr"
  project_name = var.project_name
}


###################
# EKS Module
###################

module "eks" {
  source               = "../../modules/eks"
  cluster_name         = var.cluster_name
  eks_cluster_role_arn = module.iam.eks_cluster_role_arn
  node_role_arn        = module.iam.eks_node_group_role_arn
  instance_types       = var.instance_types
  subnet_ids           = module.vpc.private_subnet_ids

  depends_on = [ module.vpc, module.iam ]
}


