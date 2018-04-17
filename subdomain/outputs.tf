output "zone_id" {
  value = "${aws_route53_zone.subdomain.0.zone_id}"
}

output "full_subdomain_name" {
  # concat sub/main then remove trailing dot
  value = "${replace("${var.subdomain_prefix}.${var.maindomain_name}", "/.$/", "")}"
}
