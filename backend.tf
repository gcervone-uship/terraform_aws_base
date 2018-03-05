terraform {
  backend "s3" {
    bucket = "ml-sre-terraform-state"
    key = "state"
    region = "us-east-1"

    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    role_arn = "${var.role_arn}"

  }
}