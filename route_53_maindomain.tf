// Main SDL hosted zone.  All accounts will have a next level subdomain.
// This domain was imported with "terraform import aws_route53_zone.mml-cloud Z3NHPDOM9AF16B"

//resource "aws_route53_zone" "mml-cloud" {
//  name = "tf.mml.cloud."
//
//  count = "${var.enable_main_domain}"
//
//  lifecycle {
//    prevent_destroy = true
//  }
//}

data "aws_route53_zone" "maindomain" {
  name =  "${var.maindomain_name}"
}