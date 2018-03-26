#
# Main domain configuration.  Required when enable_subdomain is truel.
# This will be used as a data source for subdomain operations and a target
# for adding subdomain glue records.
#
maindomain_name = "tf.mml.cloud."

#
# Subdomain configuration.  Setting enable_subdomain to true will:
#   1. Create subdomain
#   2. Add glue recrods to maindomain_name hosted zone
#   3. Request a DNS validated (automated) SSL cert for *.<subdomain
#
enable_subdomain = true
subdomain_prefix = "pt" // prototype

