module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.vpc_name}"
  cidr = "${var.vpc_cidr}"

  azs                 = "${var.vpc_azs}"
  private_subnets     = "${var.vpc_private_subnets}"
  public_subnets      = "${var.vpc_public_subnets}"
  database_subnets    = "${var.vpc_database_subnets}"
  elasticache_subnets = "${var.vpc_elasticache_subnets}"
  redshift_subnets    = "${var.vpc_redshift_subnets}"

  create_database_subnet_group = true

  // redshift subnet_group is created by default when there are defined redshift subnets, there is no flag to turn it off.
  // elastic cache subnet_group is created by default when there are defined ec subnets, there is no flag to turn it off.

  enable_nat_gateway       = true
  enable_vpn_gateway       = false
  enable_s3_endpoint       = false
  enable_dynamodb_endpoint = false
  tags = "${var.common_tags}"

}
