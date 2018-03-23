variable "region" {
  default = "us-east-1"
}

variable "enable_main_domain" {
  description = "Set to true if this account will have a main domain (not subdomain) hosted zone"
  default = false
}

variable "maindomain_name" {
  description = "Main domain for which all subdomains will be delegated from.  Don't forget the trailing dot"
}

variable "subdomain_prefix" {
  description = "prefix to be added to maindomain_name to create a subdomain.  For example 'dev', will create dev.<maindomain_name>.  This should be a unique subdomain."
}