data "aws_region" "current" {}

locals {
  fl_URL = "https://console.aws.amazon.com/cloudwatch/home?region=${data.aws_region.current.id}#logStream:group=${element(concat(aws_flow_log.vpc_flowlog.*.log_group_name, list("")), 0)}"
}

output "vpc_flowlog_URL" {
  value = "${var.enable_vpc_flow_logs ? local.fl_URL : "DISABLED"}"
}
