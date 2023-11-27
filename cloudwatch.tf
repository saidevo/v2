# Create an SNS topic
resource "aws_sns_topic" "alarm_notifications" {
  name = "AlarmNotifications"
}

# Subscribe an email address to the SNS topic (replace with your email)
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.alarm_notifications.arn
  protocol  = "email"
  endpoint  = "tejaswinibokka1811@gmail.com"
}
# Create a CloudWatch Alarm and associate it with the SNS topic
resource "aws_cloudwatch_metric_alarm" "instance_state_alarm" {
  alarm_name          = "instance-state-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "10"
  statistic           = "Minimum"
  threshold           = "2"
  actions_enabled     = true

  dimensions = {
    InstanceId = aws_instance.instance.id
  }

  alarm_description = "This alarm will trigger if the EC2 instance state check fails."
  alarm_actions = [aws_sns_topic.alarm_notifications.arn]
  depends_on = [ 
    aws_instance.instance,
    aws_sns_topic.alarm_notifications,
    aws_sns_topic_subscription.email_subscription
  ]
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alarm" {
  alarm_name          = "cpu-utilization-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "10"  # 30 seconds
  statistic           = "Average"
  threshold           = "1"
  actions_enabled     = true

  dimensions = {
    InstanceId = aws_instance.instance.id
  }

  alarm_description = "This alarm will trigger if the CPU utilization exceeds 1% for 30sec consecutive minutes."
  alarm_actions = [aws_sns_topic.alarm_notifications.arn]
  depends_on = [ 
    aws_instance.instance,
    aws_sns_topic.alarm_notifications,
    aws_sns_topic_subscription.email_subscription
  ]
}