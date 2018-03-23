// Subdomain for prototype account.
resource "aws_route53_zone" "subdomain" {
  name = "${var.subdomain_prefix}.${data.aws_route53_zone.maindomain.name}"
}

// Glue records for prototype account added to main mml.cloud
resource "aws_route53_record" "pt-ns" {
  zone_id = "${data.aws_route53_zone.maindomain.zone_id}"
  name = "${var.subdomain_prefix}.${data.aws_route53_zone.maindomain.name}"

  type    = "NS"
  ttl     = "30"

  records = [
    "${aws_route53_zone.subdomain.name_servers.0}",
    "${aws_route53_zone.subdomain.name_servers.1}",
    "${aws_route53_zone.subdomain.name_servers.2}",
    "${aws_route53_zone.subdomain.name_servers.3}",
  ]
}

//resource "aws_route53_record" "test" {
//  name    = "test"
//  type    = "A"
//  zone_id = "${aws_route53_zone.subdomain.zone_id}"
//  ttl     = "30"
//
//  records = ["127.0.0.1"]
//}

// ACM SSL Certificate
// https://www.terraform.io/docs/providers/aws/r/acm_certificate_validation.html
// SSL Cert for *
resource "aws_acm_certificate" "wildcard-cert" {
  // get rif of training dot.
  // todo need to make this more robust.  currently has many ways to fail.
  domain_name = "${replace("*.${var.subdomain_prefix}.${data.aws_route53_zone.maindomain.name}", ".cloud.", ".cloud")}"

  //  domain_name = "*.pt.tf.mml.cloud"
  validation_method = "DNS"
}

resource "aws_route53_record" "wildcard-cert_validation" {
  name    = "${aws_acm_certificate.wildcard-cert.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.wildcard-cert.domain_validation_options.0.resource_record_type}"
  zone_id = "${aws_route53_zone.subdomain.zone_id}"
  records = ["${aws_acm_certificate.wildcard-cert.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "wildcard-cert" {
  certificate_arn         = "${aws_acm_certificate.wildcard-cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.wildcard-cert_validation.fqdn}"]
}
