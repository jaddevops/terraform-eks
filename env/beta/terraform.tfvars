region                        = "us-east-2"
name                          = "jad-1"
cluster_name                  = "jad-beta"
cluster_version               = "1.19"
cluster_sg_name               = "jad-beta-sg"
eks_cluster_role              = "eks-jad-role"
ec2_ssh_key                   = "jad-eks-cluster"
disk_size                     = 50             # Size in GB
instance_types                = ["m5.2xlarge"] # For Graviton 2 Instance
launch_template_instance_type = "m5.2xlarge"   # t3a.medium 
ami_type                      = "AL2_x86_64"
service_ipv4_cidr             = ["10.232.64.0/20"]
enabled_cluster_log_types     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
vpc_name                      = "jad-eks-beta"
vpc_peer_name                 = "jad-eks-beta"
subnet_names                  = ["eks-beta-private-az1", "eks-beta-private-az2"]
cluster_subnet_names          = ["eks-beta-control-app1-az1", "eks-beta-control-app1-az2"]
min_size                      = 1
max_size                      = 3
desired_size                  = 2
node_group_name = {
  "jad_beta" = "ON_DEMAND"
}
rds_region = "us-east-2"
rds_vpc_id = "vpc-0e4e3fb0e0f739a04"
rds_subnet = "10.1.0.0/16"
