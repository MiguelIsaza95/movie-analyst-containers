resource "aws_cloudwatch_metric_alarm" "cluster_cpu_high" {
  alarm_name          = "cluster-high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.cluster.name
  }
  alarm_description = "Scale up if CPU utilization is above 80% for 300 seconds"
  alarm_actions     = [aws_autoscaling_policy.cluster_policy_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "cluster_cpu_low" {
  alarm_name          = "cluster-low-cpu"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 20

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.cluster.name
  }
  alarm_description = "Scale down if CPU utilization is above 20% for 300 seconds"
  alarm_actions     = [aws_autoscaling_policy.cluster_policy_down.arn]
}