#
# Data record for main SDL hosted zone.
#
data "aws_route53_zone" "maindomain" {
  name =  "${var.maindomain_name}"
}

#
# Create subdomain and add glue records to parent hosted zone.
#
resource "aws_route53_zone" "subdomain" {
  count = "${var.enable_subdomain}"
  name = "${var.subdomain_prefix}.${data.aws_route53_zone.maindomain.name}"
}

resource "aws_route53_record" "glue-ns" {
  count = "${var.enable_subdomain}"
  zone_id = "${data.aws_route53_zone.maindomain.zone_id}"
  name = "${var.subdomain_prefix}.${data.aws_route53_zone.maindomain.name}"

  type    = "NS"
  ttl     = "60"

  records = [
    "${aws_route53_zone.subdomain.name_servers.0}",
    "${aws_route53_zone.subdomain.name_servers.1}",
    "${aws_route53_zone.subdomain.name_servers.2}",
    "${aws_route53_zone.subdomain.name_servers.3}",
  ]
}

#
# Get Wildcard ACM SSL Certificate for subdomain.
# Fully automated via DNS validation.
#
resource "aws_acm_certificate" "wildcard-cert" {
  count = "${var.enable_subdomain}"

  // get rid of training dot.
  // todo need to make this more robust.  currently has many ways to fail.
  domain_name = "${replace("*.${var.subdomain_prefix}.${data.aws_route53_zone.maindomain.name}", ".cloud.", ".cloud")}"
  validation_method = "DNS"
}

resource "aws_route53_record" "wildcard-cert_validation" {
  count = "${var.enable_subdomain}"

  name    = "${aws_acm_certificate.wildcard-cert.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.wildcard-cert.domain_validation_options.0.resource_record_type}"
  zone_id = "${aws_route53_zone.subdomain.zone_id}"
  records = ["${aws_acm_certificate.wildcard-cert.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "wildcard-cert" {
  count = "${var.enable_subdomain}"
  certificate_arn         = "${aws_acm_certificate.wildcard-cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.wildcard-cert_validation.fqdn}"]
}

# Test record
//resource "aws_route53_record" "test" {
//  count = "${var.enable_subdomain}"
//  name    = "test"
//  type    = "A"
//  zone_id = "${aws_route53_zone.subdomain.zone_id}"
//  ttl     = "30"
//
//  records = ["127.0.0.1"]
//}