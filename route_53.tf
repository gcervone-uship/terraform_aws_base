// Main SDL hosted zone.  All accounts will have a next level subdomain.
// This domain was imported with "terraform import aws_route53_zone.mml-cloud Z3NHPDOM9AF16B"
resource "aws_route53_zone" "mml-cloud" {
  name = "tf.mml.cloud."

  lifecycle {
    prevent_destroy = true
  }
}

// Subdomain for prototype account.
resource "aws_route53_zone" "pt-tf-mml-cloud" {
  name = "pt.tf.mml.cloud."
}

// Glue records for prototype account added to main mml.cloud
resource "aws_route53_record" "pt-ns" {
  zone_id = "${aws_route53_zone.mml-cloud.zone_id}"
  name    = "pt.tf.mml.cloud."
  type    = "NS"
  ttl     = "30"

  records = [
    "${aws_route53_zone.pt-tf-mml-cloud.name_servers.0}",
    "${aws_route53_zone.pt-tf-mml-cloud.name_servers.1}",
    "${aws_route53_zone.pt-tf-mml-cloud.name_servers.2}",
    "${aws_route53_zone.pt-tf-mml-cloud.name_servers.3}",
  ]
}

resource "aws_route53_record" "test" {
  name    = "test"
  type    = "A"
  zone_id = "${aws_route53_zone.pt-tf-mml-cloud.zone_id}"
  ttl     = "30"

  records = ["127.0.0.1"]
}

// ACM SSL Certificate
// https://www.terraform.io/docs/providers/aws/r/acm_certificate_validation.html

resource "aws_acm_certificate" "test-cert" {
  domain_name       = "${aws_route53_record.test.fqdn}"
  validation_method = "DNS"
}

resource "aws_route53_record" "cert_validation" {
  name    = "${aws_acm_certificate.test-cert.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.test-cert.domain_validation_options.0.resource_record_type}"
  zone_id = "${aws_route53_zone.pt-tf-mml-cloud.zone_id}"
  records = ["${aws_acm_certificate.test-cert.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = "${aws_acm_certificate.test-cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
}

// SSL Cert for *
resource "aws_acm_certificate" "star-cert" {
  domain_name       = "*.pt.tf.mml.cloud"
  validation_method = "DNS"
}

resource "aws_route53_record" "star-cert_validation" {
  name    = "${aws_acm_certificate.star-cert.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.star-cert.domain_validation_options.0.resource_record_type}"
  zone_id = "${aws_route53_zone.pt-tf-mml-cloud.zone_id}"
  records = ["${aws_acm_certificate.star-cert.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "star-cert" {
  certificate_arn         = "${aws_acm_certificate.star-cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.star-cert_validation.fqdn}"]
}
