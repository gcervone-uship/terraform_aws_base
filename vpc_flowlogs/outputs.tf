data "aws_region" "current" {}

output "vpc_flowlog_URL" {
  value = "https://console.aws.amazon.com/cloudwatch/home?region=${data.aws_region.current.id}#logStream:group=${aws_flow_log.vpc_flowlog.log_group_name}"
}
