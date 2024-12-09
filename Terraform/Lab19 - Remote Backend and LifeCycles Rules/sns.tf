##### SNS Topic #####
resource "aws_sns_topic" "cpu_alert_topic" {
  name = var.sns_topic_name
}

##### SNS Subscription #####
resource "aws_sns_topic_subscription" "cpu_alert_target" {
  topic_arn = aws_sns_topic.cpu_alert_topic.arn
  protocol  = var.sns_target_protocol
  endpoint  = var.sns_topic_target
}
