#
# VPC Configuration
#

variable "vpc_name" {
  description = "Name tag for the VPC and used in all sub resources names"
  default     = "terraform-vpc"
}

variable "vpc_cidr" {
  description = "CIDR Network block for VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  type        = "list"
  description = "Availability zones to be used for subnet assignment"
}

variable "vpc_private_subnets" {
  type        = "list"
  description = "Private subnets will be spread across defined AZs and route to internet via nat gateway"
}

variable "vpc_public_subnets" {
  type        = "list"
  description = "Public subnets will be spread across defined AZs.  Will include NAT gateway."
}

variable "vpc_database_subnets" {
  type        = "list"
  description = "Database subnets will be spread across defined AZs and a subnetgroup created."
}

variable "vpc_elasticache_subnets" {
  type        = "list"
  description = "Elasticache subnets will be spread across defined AZs and a subnetgroup created."
}

variable "vpc_redshift_subnets" {
  type        = "list"
  description = "Redshift subnets will be spread across defined AZs and a subnetgroup created."
}

variable "common_tags" {
  type        = "map"
  description = "Tags used by default for the resources created by terraform"

  default = {
    Terraform   = "true"
    division    = "unknown"
    project     = "unknown"
    environment = "unknown"
    envid       = "unknown"
    role        = "unknown"
  }
}
