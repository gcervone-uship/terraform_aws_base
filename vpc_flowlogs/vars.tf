variable "traffic_type" {
  description = "Type of traffic that flow log will capture.  Possible values: ALL, ACCEPT, REJECT"
  default     = "ALL"
}

variable "vpc_id" {
  description = "VPC for which to enable the flowlog"
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

variable "retention_in_days" {
  description = "Retention policy for flow logs in days"
  default     = "365"
}

variable "enable_vpc_flow_logs" {
  description = "Enable the creation of flow logs for this VPC"
  default     = false
}
