resource "aws_s3_bucket" "terraform_state" {
  bucket = "ml-sre-terraform-state"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "terraform-vpc"
  cidr = "10.0.0.0/16"

  azs                 = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets      = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  database_subnets    = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]
  elasticache_subnets = ["10.0.31.0/24", "10.0.32.0/24", "10.0.33.0/24"]
  redshift_subnets    = ["10.0.41.0/24", "10.0.42.0/24", "10.0.43.0/24"]

  create_database_subnet_group = true
  // redshift subnet_group is created by default when there are defined redshift subnets, there is no flag to turn it off.
  // elastic cache subnet_group is created by default when there are defined ec subnets, there is no flag to turn it off.

  enable_nat_gateway = true
  enable_vpn_gateway = false

  enable_s3_endpoint       = false
  enable_dynamodb_endpoint = false

  tags = {
    Terraform = "true"
    division = "operations"
    project = "aws base"
    environment = "proto"
    envid = "unknown"
    role = "unknown"
  }
}

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
