variable "region" {
  default = "us-east-1"
}

variable "maindomain_name" {
  description = "Main domain for which all subdomains will be delegated from.  Don't forget the trailing dot.  (ex. 'mml.cloud.'"
  default = "changeme.local."
}

variable "enable_subdomain" {
  description = "Set to true if this account will have a subdomain hosted zone that will be delegated from maindomain"
  default = false
}
variable "subdomain_prefix" {
  description = "prefix to be added to maindomain_name to create a subdomain.  For example 'dev', will create dev.<maindomain_name>.  This should be a unique subdomain."
  default = "changeme"
}

