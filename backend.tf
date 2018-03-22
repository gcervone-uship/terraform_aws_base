terraform {
  backend "s3" {
    bucket = "ml-sre-terraform-state"
    key    = "state"
    region = "us-east-1"

    # uses access_key and secret_key from default aws config
    role_arn = "arn:aws:iam::758748077998:role/sre"
  }
}
