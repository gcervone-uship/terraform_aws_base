##############################################################################
#                                                                            #
#                     FEATURE FLAGS AND COMMON TAGS                          #
#                                                                            #
##############################################################################

variable "enable_vpc_peering" {
  description = "Boolean - set to true to enable vpc peering"
  default     = false
}

variable "enable_vpc_peering_route_table_updates" {
  description = "Boolean - if enable_vpc_peering is true, set this to true to enable route table updates."
  default     = false
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

##############################################################################
#                                                                            #
#                              LOCAL VPC INFO                                #
#                                                                            #
##############################################################################

variable "my_vpcid" {
  description = "VPC id for the VPC on this side of the connection."
}

variable "my_vpc_cidr_block" {
  description = "CIDR block for the peer to connect to"
}

variable "my_public_route_table_ids" {
  type        = "list"
  description = "List of IDs of public route tables in VPC peer"
}

variable "my_public_route_table_ids_count" {
  description = "Count of list of IDs of public route tables in VPC peer"
}

variable "my_private_route_table_ids" {
  type        = "list"
  description = "List of IDs of private route tables in VPC peer"
}

variable "my_private_route_table_ids_count" {
  description = "Count of list of IDs of private route tables in VPC peer"
}

##############################################################################
#                                                                            #
#                               PEER VPC INFO                                #
#                                                                            #
##############################################################################

variable "peer_vpc_owner_id" {
  description = "VPC ID owner for the peer to connect to"
}

variable "peer_vpc_region" {
  description = "VPC region for the peer to connect to"
}

variable "peer_vpcid" {
  description = "VPC ID for the peer to connect to"
}

variable "peer_vpc_cidr_block" {
  description = "CIDR block for the peer to connect to"
}

variable "peer_public_route_table_ids" {
  type        = "list"
  description = "List of IDs of public route tables in VPC peer"
  default = []
}

variable "peer_public_route_table_ids_count" {
  description = "Count of list of IDs of public route tables in VPC peer"
}

variable "peer_private_route_table_ids" {
  type        = "list"
  description = "List of IDs of private route tables in VPC peer"
  default = []
}

variable "peer_private_route_table_ids_count" {
  description = "Count of list of IDs of private route tables in VPC peer"
}
