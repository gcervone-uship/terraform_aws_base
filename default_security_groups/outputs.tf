output "private_nets_ssh_security_group_id" {
  value = "${module.private_ssh_security_group.this_security_group_id}"
}