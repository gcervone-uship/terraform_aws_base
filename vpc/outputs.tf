# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.vpc.vpc_id}"
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value = "${module.vpc.vpc_cidr_block}"
}

output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value = "${module.vpc.public_route_table_ids}"
}

output "public_route_table_ids_count" {
  description = "Count of list of IDs of public route tables"
  value = "${length(module.vpc.public_route_table_ids)}"
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value = "${module.vpc.private_route_table_ids}"
}

output "private_route_table_ids_count" {
  description = "Count of list of IDs of private route tables"
  value = "${length(module.vpc.private_route_table_ids)}"
}
output "private_subnets" {
  description = "List of IDs of private subnets"
  value = "${module.vpc.private_subnets}"
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value = "${module.vpc.public_subnets}"
}