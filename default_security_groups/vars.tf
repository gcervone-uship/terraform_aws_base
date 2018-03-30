variable "common_tags" {
  type        = "map"
  description = "Tags used by default for the resources created by terraform"

  default = {
    Terraform   = "true"
    division    = "unknown"
    project     = "unknown"
    environment = "unknown"
    envid       = "unknown"
    role        = "unknown"
  }
}

variable "vpc_id" {
  description = "Associate all created security groups with this VPC."
}

variable "enable_default_security_groups" {
  description = "Boolean - set to true to enable creating the default security groups"
  default = false
}