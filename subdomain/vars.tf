#
# Main domain configuration.  Required when enable_subdomain is truel.
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
