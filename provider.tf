provider "aws" {
  version = "~> 1.10"

  # No credential explicity set here because they come from either the environment or the global credentials file.

  region = "${var.region}"
  assume_role {
    role_arn = "${var.admin_role_arn}"
  }
}
