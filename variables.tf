variable "region" {
  default = "us-east-1"
}

#
# Auth
#
variable "admin_role_arn" {
  description = "Role for creating / destroying aws resources."
}

variable "backend_s3bucket_role_arn" {
  description = "Role for accessing the s3 bucket used for the state file"
}

#
# Common Tags
#
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

#
# Commit map used by the pipeline to insert infra and code commit hashes.
#
variable "commit_map" {
  type        = "map"
  description = "Map with the commit hash for both infra and config."

  default = {
    infrastructure_hash = "unknown"
    configuration_hash  = "unknown"
  }
}

#
# Main domain configuration.  Required when enable_subdomain is truel.
# This will be used as a data source for subdomain operations and a target
# for adding subdomain glue records.
#
variable "maindomain_name" {
  description = "Main domain for which all subdomains will be delegated from.  Don't forget the trailing dot.  (ex. 'mml.cloud.'"
  default     = "changeme.local."
}

#
# Subdomain configuration.  Setting enable_subdomain to true will:
#   1. Create subdomain
#   2. Add glue recrods to maindomain_name hosted zone
#   3. Request a DNS validated (automated) SSL cert for *.<subdomain
#
variable "enable_subdomain" {
  description = "Set to true if this account will have a subdomain hosted zone that will be delegated from maindomain"
  default     = false
}

variable "subdomain_prefix" {
  description = "prefix to be added to maindomain_name to create a subdomain.  For example 'dev', will create dev.<maindomain_name>.  This should be a unique subdomain."
  default     = "changeme"
}

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
