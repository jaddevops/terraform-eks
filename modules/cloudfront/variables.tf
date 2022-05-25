variable "bucket_name" {
  type        = string
  description = "xrengine-static-resources."
}
variable "region" {
  type        = string
  default     = "us-west-1"
  description = "xrengine-static-resources."
}

variable "domain_name" {
  description = "Domain name"
  type        = string
}
