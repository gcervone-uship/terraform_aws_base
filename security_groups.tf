module "rfc_1918_ssh_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "rfc-1918-ssh-sg"
  description = "Security group with SSH ports open for RFC 1918 private subnets, egress ports are all world open"
  vpc_id      = "${module.vpc.vpc_id}"

  // RFC 1918
  ingress_cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]

  auto_ingress_with_self = []

  tags = {
    Terraform = "true"
    division = "operations"
    project = "aws base"
    environment = "proto"
    envid = "unknown"
    role = "unknown"
  }


}

module "rfc_1918_postgresql_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/postgresql"

  name        = "rfc-1918-postgres-sg"
  description = "Security group with PostgreSQL ports open for RFC 1918 private subnets, egress ports are all world open"
  vpc_id      = "${module.vpc.vpc_id}"

  // RFC 1918
  ingress_cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]

  auto_ingress_with_self = []

  tags = {
    Terraform = "true"
    division = "operations"
    project = "aws base"
    environment = "proto"
    envid = "unknown"
    role = "unknown"
  }

}

module "rfc_1918_http_80_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "rfc-1918-http-80-sg"
  description = "Security group with tcp 80 open for RFC 1918 private subnets, egress ports are all world open"
  vpc_id      = "${module.vpc.vpc_id}"

  // RFC 1918
  ingress_cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]

  auto_ingress_with_self = []

  tags = {
    Terraform = "true"
    division = "operations"
    project = "aws base"
    environment = "proto"
    envid = "unknown"
    role = "unknown"
  }

}

module "rfc_1918_https_443_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/https-443"

  name        = "rfc-1918-https-443-sg"
  description = "Security group with tcp 443 open for RFC 1918 private subnets, egress ports are all world open"
  vpc_id      = "${module.vpc.vpc_id}"

  // RFC 1918
  ingress_cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]

  auto_ingress_with_self = []

  tags = {
    Terraform = "true"
    division = "operations"
    project = "aws base"
    environment = "proto"
    envid = "unknown"
    role = "unknown"
  }

}
