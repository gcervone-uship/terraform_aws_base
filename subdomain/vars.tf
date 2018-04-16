#
# Main domain configuration.  Required when enable_subdomain is true.
# This will be used as a data source for subdomain operations and a target
# for adding subdomain glue records.
#
variable "maindomain_name" {
  description = "Main domain for which all subdomains will be delegated from.  Don't forget the trailing dot.  (ex. 'mml.cloud.'"
  default     = "changeme.local."
}

variable "subdomain_prefix" {
  description = "prefix to be added to maindomain_name to create a subdomain.  For example 'dev', will create dev.<maindomain_name>.  This should be a unique subdomain."
  default     = "changeme"
}

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

variable "enable_subdomain" {
  description = "Boolean - set to true to enable subdomain creation"
  default     = false
}

variable "enable_subdomain_wildcard_cert" {
  description = "Boolean - set to true to enable creation of a wildcard cert for the subdomain"
  default     = false
}
