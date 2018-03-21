locals {

  common_tags = {
    Terraform = "true"
    division = "operations"
    project = "aws base"
    environment = "proto"
    envid = "unknown"
    role = "unknown"
  }

  rfc_1918_private_networks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  all_networks = ["0.0.0.0/0"]

  my_vpc = "${module.vpc.vpc_id}"

}

#####################################################
# Default Security groups open to private networks
#####################################################

module "private_ssh_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "private-ssh-sg"
  description = "tcp 22 open for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${local.my_vpc}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  tags = "${local.common_tags}"
}

module "private_http_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "private-http-sg"
  description = "tcp 80 open for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${local.my_vpc}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  tags = "${local.common_tags}"
}

module "private_https_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/https-443"

  name        = "private-https-sg"
  description = "tcp 443 open for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${local.my_vpc}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  tags = "${local.common_tags}"
}

module "private_rdp_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/rdp"

  name        = "private-rdp-sg"
  description = "tcp/udp 3389 for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${local.my_vpc}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  tags = "${local.common_tags}"
}

module "private_redshift_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/redshift"

  name        = "private-redshift-sg"
  description = "tcp 5439 for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${local.my_vpc}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  tags = "${local.common_tags}"
}

module "private_mysql_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/mysql"

  name        = "private-mysql-sg"
  description = "tcp 3306 for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${local.my_vpc}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  tags = "${local.common_tags}"
}

module "private_postgresql_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/postgresql"

  name        = "private-postgres-sg"
  description = "tcp 5432 open for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${local.my_vpc}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  tags = "${local.common_tags}"
}

module "private_mssql_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/mssql"

  name        = "private-mssql-sg"
  description = "tcp 1433/2383/4022 and udp 1434 open for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${local.my_vpc}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  tags = "${local.common_tags}"
}

module "private_redis_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/redis"

  name        = "private-redis-sg"
  description = "tcp 6379 for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${local.my_vpc}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  tags = "${local.common_tags}"
}

module "private_memcached_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/memcached"

  name        = "private-memcached-sg"
  description = "tcp 11211 for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${local.my_vpc}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  tags = "${local.common_tags}"
}

#####################################################
# Default Security groups open to all networks
#####################################################

module "public_https_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/https-443"
  
  name        = "public-https-sg"
  description = "tcp 443 open to all networks, egress ports are open to all networks"
  vpc_id      = "${local.my_vpc}"
  
  ingress_cidr_blocks    = "${local.all_networks}"
  auto_ingress_with_self = []
  
  tags = "${local.common_tags}"
}

module "public_http_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "public-http-sg"
  description = "tcp 80 open to all networks, egress ports are open to all networks"
  vpc_id      = "${local.my_vpc}"

  ingress_cidr_blocks    = "${local.all_networks}"
  auto_ingress_with_self = []

  tags = "${local.common_tags}"
}