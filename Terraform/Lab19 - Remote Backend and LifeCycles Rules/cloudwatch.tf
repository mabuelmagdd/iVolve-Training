##### CloudWatch #####
resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alarm" {
  alarm_name                = var.cw_alarm_name
  comparison_operator       = var.cw_comparison_operator
  evaluation_periods        = var.cw_evaluation_periods
  metric_name               = var.cw_metric_name
  namespace                 = var.cw_namespace
  period                    = var.cw_period
  statistic                 = var.cw_statistic
  threshold                 = var.cw_threshold
  alarm_description         = var.cw_alarm_description
  insufficient_data_actions = []
  ok_actions                = [aws_sns_topic.cpu_alert_topic.arn]
  alarm_actions             = [aws_sns_topic.cpu_alert_topic.arn]

  dimensions = {
    InstanceId = aws_instance.ec2.id
  }
}