terraform {
  backend "s3" {
    bucket = "terraform_state"
    key = "state"
    region = "us-east-1"
  }
}