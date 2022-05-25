
module "vpc" {
  source           = "../../modules/vpc"
  name             = var.vpc_name
  region           = var.region
  eks_cluster_name = var.cluster_name
}

#module "vpc_peering" {
 # source      = "../../modules/vpc_peering"
 # region      = var.rds_region
 # vpc_id      = module.vpc.vpc_id
 # natgw_ids   = module.vpc.natgw_ids
 # peer_vpc_id = var.rds_vpc_id
 # rds_subnet  = var.rds_subnet
 # name        = var.vpc_peer_name
#}

resource "aws_kms_key" "eks" {
  description = "EKS Secret Encryption Key"
}
# EKS Cluster
module "eks_cluster" {
  source                    = "../../modules/eks_cluster"
  cluster_name              = var.cluster_name
  cluster_version           = "1.21"
  cluster_sg_name           = "beta-cluster-sg"
  eks_cluster_role          = var.eks_cluster_role
  service_ipv4_cidr         = var.service_ipv4_cidr
  vpc_id                    = module.vpc.vpc_id
  vpc_cidr                  = module.vpc.vpc_cidr_block
  private_subnet_ids        = module.vpc.private_subnets
  enabled_cluster_log_types = var.enabled_cluster_log_types
  cluster_encryption_config = [
    {
      provider_key_arn = aws_kms_key.eks.arn
      resources        = ["secrets"]
    }
  ]
}

module "eks_worker_nodes" {
  depends_on         = [module.eks_cluster]
  source             = "../../modules/eks_node_group"
  cluster_name       = var.cluster_name
  private_subnet_ids = module.vpc.private_subnets
  node_group_name    = var.node_group_name
  ec2_ssh_key        = var.ec2_ssh_key
  ami_type           = var.ami_type
  instance_types     = var.instance_types
  desired_size       = var.desired_size
  max_size           = var.max_size
  min_size           = var.min_size
}
