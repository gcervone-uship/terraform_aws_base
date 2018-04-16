provider "aws" {
  alias = "maindomain"
}

provider "aws" {}

#
# Data record for main SDL hosted zone.
#
data "aws_route53_zone" "maindomain" {
  provider = "aws.maindomain"
  name     = "${var.maindomain_name}"
}

##############################################################################
#                                                                            #
#        Create subdomain and add glue records to parent hosted zone         #
#                                                                            #
##############################################################################

resource "aws_route53_zone" "subdomain" {
  count = "${var.enable_subdomain}"
  name  = "${var.subdomain_prefix}.${data.aws_route53_zone.maindomain.name}"
}

resource "aws_route53_record" "glue-ns" {
  count    = "${var.enable_subdomain}"
  provider = "aws.maindomain"
  zone_id  = "${data.aws_route53_zone.maindomain.zone_id}"
  name     = "${var.subdomain_prefix}.${data.aws_route53_zone.maindomain.name}"

  type = "NS"
  ttl  = "60"

  records = [
    "${aws_route53_zone.subdomain.name_servers.0}",
    "${aws_route53_zone.subdomain.name_servers.1}",
    "${aws_route53_zone.subdomain.name_servers.2}",
    "${aws_route53_zone.subdomain.name_servers.3}",
  ]
}

##############################################################################
#                                                                            #
#               Get Wildcard ACM SSL Certificate for subdomain.              #
#                       Fully automated via DNS validation.                  #
#                                                                            #
##############################################################################

resource "aws_acm_certificate" "wildcard-cert" {
  count = "${var.enable_subdomain_wildcard_cert}"

  # maindomain.name returns a trailing dot we have to remove
  domain_name       = "${replace("*.${var.subdomain_prefix}.${data.aws_route53_zone.maindomain.name}", "/.$/", "")}"
  validation_method = "DNS"
}

resource "aws_route53_record" "wildcard-cert_validation" {
  count = "${var.enable_subdomain_wildcard_cert}"

  name    = "${aws_acm_certificate.wildcard-cert.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.wildcard-cert.domain_validation_options.0.resource_record_type}"
  zone_id = "${aws_route53_zone.subdomain.zone_id}"
  records = ["${aws_acm_certificate.wildcard-cert.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "wildcard-cert" {
  count = "${var.enable_subdomain_wildcard_cert}"

  certificate_arn         = "${aws_acm_certificate.wildcard-cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.wildcard-cert_validation.fqdn}"]
}
