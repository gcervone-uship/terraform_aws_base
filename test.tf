provider "aws" {
  # profile = "sre_prototype"

  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"

  assume_role {
    role_arn     = "${var.role_arn}"
  }
}

//resource "aws_instance" "example" {
//  ami           = "ami-b374d5a5"
//  instance_type = "t2.micro"
//
//  tags {
//    Name = "TerraformTest"
//  }
//
//  provisioner "local-exec" {
//    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
//  }
//}
//
//resource "aws_eip" "ip" {
//  instance = "${aws_instance.example.id}"
//}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "ml-sre-terraform-state"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}