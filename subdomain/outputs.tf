output "zone_id" {
  value = "${aws_route53_zone.subdomain.0.zone_id}"
}