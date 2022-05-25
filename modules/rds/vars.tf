variable "engine" {
  description = "DB engine"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "DB engine version"
  type        = string
  default     = "5.7.19"
}

variable "instance_class" {
  description = "DB instance class"
  type        = string
  default     = "db.t2.large"
}

variable "allocated_storage" {
  description = "DB size"
  type        = number
  default     = 10
}

variable "db_name" {
  description = "DB Name"
  type        = string
  default     = "xrengine"
}

variable "db_username" {
  description = "DB Username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "DB Password"
  type        = string
  default     = "admin"
}

variable "monitoring_role_name" {
  description = "Monitoring Role Name"
  type        = string
  default     = "xreRDSMonitoringRole"
}

variable "private_subnet_ids" {
  type = list(string)
  description = "Set of instance types associated with the EKS Node Group."
  default     = []
}

variable "db_subnet_group_name" {
  description = "Name of the Database Security Group"
  type        = string
  default     = ""
}

variable "vpc_name" {
  type = list(string)
  default = []
}

variable "subnet_names" {
  type = list(string)
  default = []
}

variable tags {
  type = "map"

  default = {
    "Environment" = "Development"
  }
}
