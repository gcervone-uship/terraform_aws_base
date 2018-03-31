# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.vpc.vpc_id}"
}

output "a_private_subnet" {
  description = "One of the private subnets for placing a test server."
  value = "${module.vpc.private_subnets.0.id}"
}