variable "workspace_iam_roles" {
  type = "map"

  default = {
    default   = "arn:aws:iam::758748077998:role/sre"
    prototype = "arn:aws:iam::758748077998:role/sre"
  }
}

provider "aws" {
  # No credential explicity set here because they come from either the environment  # or the global credentials file.

  region = "${var.region}"

  assume_role {
    role_arn = "${var.workspace_iam_roles[terraform.workspace]}"
  }
}
