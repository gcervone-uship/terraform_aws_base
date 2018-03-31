#
# Main domain configuration.  Required when enable_subdomain is truel.
# This will be used as a data source for subdomain operations and a target
# for adding subdomain glue records.
#
variable "my_vpcid" {
  description = "VPC id for the VPC on this side of the connection."
}

variable "peer_vpcid" {
  description = "VPC ID for the peer to connect to"
}

variable "peer_vpc_owner_id" {
  description = "VPC ID owner for the peer to connect to"
}

variable "peer_vpc_region" {
  description = "VPC region for the peer to connect to"
}

variable "enable_vpc_peering" {
  description = "Boolean - set to true to enable vpc peering"
  default = false
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