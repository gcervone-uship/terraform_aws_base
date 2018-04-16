# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.vpc.vpc_id}"
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = "${module.vpc.vpc_cidr_block}"
}

output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = "${module.vpc.public_route_table_ids}"
}

# **** WORKAROUND! (See README.md)
# Using a computed resource wasn't supported downstream so
# make static "1".  With out current implementation this should
# be okay, but this workaround will break if this changes.
output "public_route_table_ids_count" {
  description = "Count of list of IDs of public route tables"
  value       = "1"
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = "${module.vpc.private_route_table_ids}"
}

# **** WORKAROUND! (See README.md)
# Using the number of vpc_azs to compute the number of private
# routing tables to prevent this from being a computed value.
# A count downstream in vpc_peering doesn't currently support computed
# values.
output "private_route_table_ids_count" {
  description = "Count of list of IDs of private route tables"
  value       = "${length(var.vpc_azs)}"
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = "${module.vpc.private_subnets}"
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = "${module.vpc.public_subnets}"
}
