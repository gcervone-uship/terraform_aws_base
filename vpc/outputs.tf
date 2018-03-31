# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.vpc.vpc_id}"
}

output "private_subnets" {
  description = "Private subnets for placing a test server."
  value = "${module.vpc.private_subnets}"
}