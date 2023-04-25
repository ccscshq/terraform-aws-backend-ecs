resource "aws_cloudwatch_log_group" "this" {
  name = local.log_group_name
}
