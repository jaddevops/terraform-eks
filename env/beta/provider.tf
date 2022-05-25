terraform {
   backend "s3" {
   bucket = "jad1bucket"
   key    = "eks-cluster-state"
   region = "us-east-2"
  }
}

provider "aws" {
  region = var.region
}
