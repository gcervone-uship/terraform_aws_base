output "private_ssh_security_group_id" {
  value = "${module.private_ssh_security_group.this_security_group_id}"
}

output "private_http_security_group_id" {
  value = "${module.private_http_security_group.this_security_group_id}"
}

output "private_https_security_group_id" {
  value = "${module.private_https_security_group.this_security_group_id}"
}

output "private_rdp_security_group_id" {
  value = "${module.private_rdp_security_group.this_security_group_id}"
}

output "private_redshift_security_group_id" {
  value = "${module.private_redshift_security_group.this_security_group_id}"
}

output "private_mysql_security_group_id" {
  value = "${module.private_mysql_security_group.this_security_group_id}"
}

output "private_postgresql_security_group_id" {
  value = "${module.private_postgresql_security_group.this_security_group_id}"
}

output "private_mssql_security_group_id" {
  value = "${module.private_mssql_security_group.this_security_group_id}"
}

output "private_redis_security_group_id" {
  value = "${module.private_redis_security_group.this_security_group_id}"
}

output "private_memcached_security_group_id" {
  value = "${module.private_memcached_security_group.this_security_group_id}"
}

output "private_nfs_security_group_id" {
  value = "${module.private_nfs_security_group.this_security_group_id}"
}

output "public_https_security_group_id" {
  value = "${module.public_https_security_group.this_security_group_id}"
}

output "public_http_security_group_id" {
  value = "${module.public_http_security_group.this_security_group_id}"
}
