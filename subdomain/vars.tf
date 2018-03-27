#
# Main domain configuration.  Required when enable_subdomain is truel.
# This will be used as a data source for subdomain operations and a target
# for adding subdomain glue records.
#
variable "maindomain_name" {
  description = "Main domain for which all subdomains will be delegated from.  Don't forget the trailing dot.  (ex. 'mml.cloud.'"
  default     = "changeme.local."
}

#
# Subdomain configuration.  Setting enable_subdomain to true will:
#   1. Create subdomain
#   2. Add glue recrods to maindomain_name hosted zone
#   3. Request a DNS validated (automated) SSL cert for *.<subdomain
#
variable "enable_subdomain" {
  description = "Set to true if this account will have a subdomain hosted zone that will be delegated from maindomain"
  default     = false
}

variable "subdomain_prefix" {
  description = "prefix to be added to maindomain_name to create a subdomain.  For example 'dev', will create dev.<maindomain_name>.  This should be a unique subdomain."
  default     = "changeme"
}
