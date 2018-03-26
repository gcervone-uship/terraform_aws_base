# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.vpc.vpc_id}"
}

output "infra_commit" {
  value = "${var.commit_map["infrastructure_hash"]}"
}

output "config_commit" {
  value = "${var.commit_map["configuration_hash"]}"
}
