#
# Common tags used by resources created by this module.
#
common_tags = {
  Terraform   = "true"
  division    = "operations"
  project     = "aws base"
  environment = "proto"
  envid       = "unknown"
  role        = "unknown"
}

#
# Main domain configuration.  Required when enable_subdomain is true.
# This will be used as a data source for subdomain operations and a target
# for adding subdomain glue records.
#
maindomain_name = "tf.mml.cloud."

#
# Subdomain configuration.  Setting enable_subdomain to true will:
#   1. Create subdomain
#   2. Add glue recrods to maindomain_name hosted zone
#   3. Request a DNS validated (automated) SSL cert for *.<subdomain
#
enable_subdomain = true
subdomain_prefix = "pt" // prototype

#
# VPC Configuration
#

vpc_name = "terraform-vpc"
vpc_cidr = "10.0.0.0/16"
vpc_azs = ["us-east-1a", "us-east-1b", "us-east-1c"]
vpc_private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
vpc_public_subnets = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
vpc_database_subnets = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]
vpc_elasticache_subnets = ["10.0.31.0/24", "10.0.32.0/24", "10.0.33.0/24"]
vpc_redshift_subnets = ["10.0.41.0/24", "10.0.42.0/24", "10.0.43.0/24"]
