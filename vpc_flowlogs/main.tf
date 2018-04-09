# Enable flow log for the requested VPC.
resource "aws_flow_log" "vpc_flowlog" {
  count = "${var.enable_vpc_flow_logs}"

  iam_role_arn   = "${aws_iam_role.vpc_flowlog_role.arn}"
  log_group_name = "flowlog_${var.vpc_id}"
  traffic_type   = "${var.traffic_type}"
  vpc_id         = "${var.vpc_id}"
}

# Create a log group for receiving the flow logs from VPC
resource "aws_cloudwatch_log_group" "vpc_flowlog_log_group" {
  count = "${var.enable_vpc_flow_logs}"

  name              = "flowlog_${var.vpc_id}"
  retention_in_days = "${var.retention_in_days}"
  tags              = "${var.common_tags}"
}

# Create role used by the flow-log service that enables it to write to the log group
resource "aws_iam_role" "vpc_flowlog_role" {
  count = "${var.enable_vpc_flow_logs}"

  name = "flowlog_${var.vpc_id}_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Inline policy for the vpc_flowlog_role
resource "aws_iam_role_policy" "vpc_flowlog_policy" {
  count = "${var.enable_vpc_flow_logs}"

  role = "${aws_iam_role.vpc_flowlog_role.id}"
  name = "vpc_flowlog_policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "${aws_cloudwatch_log_group.vpc_flowlog_log_group.arn}"
    }
  ]
}
EOF
}
