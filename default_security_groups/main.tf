locals {
  #
  # Tags applied to all security groups
  #
  sg_tags = {
    role = "default security groups"
  }

  #
  # Ingress rules applied to all security group.
  # Add ICMP to all rules
  #
  common_ingress_rules = ["all-icmp"]

  #
  # Private security groups allow ingress from these networks
  #
  rfc_1918_private_networks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]

  #
  # Public security groups allow ingress from these networks
  #
  all_networks = ["0.0.0.0/0"]
}

##############################################################################
#                                                                            #
#         DEFAULT SECURITY GROUPS OPEN TO **PRIVATE** NETWORKS               #
#                                                                            #
##############################################################################
module "private_ssh_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  create = "${var.enable_default_security_groups}"

  name        = "private-ssh-sg"
  description = "tcp 22 open for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${var.vpc_id}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  ingress_rules = "${local.common_ingress_rules}"

  tags = "${merge(var.common_tags, local.sg_tags)}"
}

module "private_http_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  create = "${var.enable_default_security_groups}"

  name        = "private-http-sg"
  description = "tcp 80 open for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${var.vpc_id}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  ingress_rules = "${local.common_ingress_rules}"

  tags = "${merge(var.common_tags, local.sg_tags)}"
}

module "private_https_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/https-443"

  create = "${var.enable_default_security_groups}"

  name        = "private-https-sg"
  description = "tcp 443 open for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${var.vpc_id}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  ingress_rules = "${local.common_ingress_rules}"

  tags = "${merge(var.common_tags, local.sg_tags)}"
}

module "private_rdp_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/rdp"

  create = "${var.enable_default_security_groups}"

  name        = "private-rdp-sg"
  description = "tcp/udp 3389 for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${var.vpc_id}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  ingress_rules = "${local.common_ingress_rules}"

  tags = "${merge(var.common_tags, local.sg_tags)}"
}

module "private_redshift_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/redshift"

  create = "${var.enable_default_security_groups}"

  name        = "private-redshift-sg"
  description = "tcp 5439 for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${var.vpc_id}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  ingress_rules = "${local.common_ingress_rules}"

  tags = "${merge(var.common_tags, local.sg_tags)}"
}

module "private_mysql_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/mysql"

  create = "${var.enable_default_security_groups}"

  name        = "private-mysql-sg"
  description = "tcp 3306 for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${var.vpc_id}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  ingress_rules = "${local.common_ingress_rules}"

  tags = "${merge(var.common_tags, local.sg_tags)}"
}

module "private_postgresql_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/postgresql"

  create = "${var.enable_default_security_groups}"

  name        = "private-postgres-sg"
  description = "tcp 5432 open for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${var.vpc_id}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  ingress_rules = "${local.common_ingress_rules}"

  tags = "${merge(var.common_tags, local.sg_tags)}"
}

module "private_mssql_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/mssql"

  create = "${var.enable_default_security_groups}"

  name        = "private-mssql-sg"
  description = "tcp 1433/2383/4022 and udp 1434 open for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${var.vpc_id}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  ingress_rules = "${local.common_ingress_rules}"

  tags = "${merge(var.common_tags, local.sg_tags)}"
}

module "private_redis_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/redis"

  create = "${var.enable_default_security_groups}"

  name        = "private-redis-sg"
  description = "tcp 6379 for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${var.vpc_id}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  ingress_rules = "${local.common_ingress_rules}"

  tags = "${merge(var.common_tags, local.sg_tags)}"
}

module "private_memcached_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/memcached"

  create = "${var.enable_default_security_groups}"

  name        = "private-memcached-sg"
  description = "tcp 11211 for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${var.vpc_id}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  ingress_rules = "${local.common_ingress_rules}"

  tags = "${merge(var.common_tags, local.sg_tags)}"
}

module "private_nfs_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/nfs"

  create = "${var.enable_default_security_groups}"

  name        = "private-nfs-sg"
  description = "tcp 2049 for RFC 1918 private subnets, egress ports are open to all networks"
  vpc_id      = "${var.vpc_id}"

  ingress_cidr_blocks    = "${local.rfc_1918_private_networks}"
  auto_ingress_with_self = []

  ingress_rules = "${local.common_ingress_rules}"

  tags = "${merge(var.common_tags, local.sg_tags)}"
}

##############################################################################
#                                                                            #
#             DEFAULT SECURITY GROUPS OPEN TO **ALL** NETWORKS               #
#                                                                            #
##############################################################################
module "public_https_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/https-443"

  create = "${var.enable_default_security_groups}"

  name        = "public-https-sg"
  description = "tcp 443 open to all networks, egress ports are open to all networks"
  vpc_id      = "${var.vpc_id}"

  ingress_cidr_blocks    = "${local.all_networks}"
  auto_ingress_with_self = []

  ingress_rules = "${local.common_ingress_rules}"

  tags = "${merge(var.common_tags, local.sg_tags)}"
}

module "public_http_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  create = "${var.enable_default_security_groups}"

  name        = "public-http-sg"
  description = "tcp 80 open to all networks, egress ports are open to all networks"
  vpc_id      = "${var.vpc_id}"

  ingress_cidr_blocks    = "${local.all_networks}"
  auto_ingress_with_self = []

  ingress_rules = "${local.common_ingress_rules}"

  tags = "${merge(var.common_tags, local.sg_tags)}"
}
