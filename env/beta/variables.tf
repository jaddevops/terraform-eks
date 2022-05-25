variable "region" {
  default = ""
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
  default     = ""
}

variable "cluster_version" {
  type        = string
  description = "EKS cluster version"
  default     = ""
}

variable "enabled_cluster_log_types" {
  type    = list(string)
  default = []
}

variable "vpc_name" {
  type    = string
  default = ""
}

variable "subnet_names" {
  type    = list(string)
  default = []
}

variable "cluster_subnet_names" {
  type    = list(string)
  default = []
}

variable "eks_cluster_role" {
  type    = string
  default = ""
}

variable "node_group_name" {
  description = "Name of the dev Node Group"
  type        = map(any)
  default     = {}
}

variable "ec2_ssh_key" {
  description = "ssh key pair for worker nodes"
  type        = string
  default     = ""
}

variable "service_ipv4_cidr" {
  type    = list(string)
  default = [] #"0.0.0.0/0"
}


variable "instance_types" {
  type        = list(string)
  default     = []
  description = "Set of instance types associated with the EKS Node Group."
}

variable "launch_template_instance_type" {
  type        = string
  default     = ""
  description = "Set of instance types associated with launch template."
}

variable "ami_type" {
  type        = string
  description = "AMI type for the EKS Node Group instance."
  default     = ""
}

variable "cluster_sg_name" {
  description = "Name of the EKS cluster Security Group"
  type        = string
  default     = ""
}

variable "disk_size" {
  description = "Disk size in GiB for worker nodes."
  type        = number
}


variable "desired_size" {
  description = "Desired number of worker nodes in dev group"
  default     = 1
  type        = number
}

variable "max_size" {
  description = "Maximum number of worker nodes in dev group."
  default     = 2
  type        = number
}

variable "min_size" {
  description = "Minimum number of worker nodes in dev group."
  default     = 1
  type        = number
}

variable "rds_region" {
  type    = string
  default = ""
}

variable "rds_vpc_id" {
  type    = string
  default = ""
}

variable "vpc_peer_name" {
  type    = string
  default = ""
}

variable "rds_subnet" {
  type    = string
  default = ""
}
