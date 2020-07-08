resource "aws_appautoscaling_target" "proxy" {
  max_capacity       = 4
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.movieanalyst.name}/${aws_ecs_service.proxy-ecs-service.name}"
#  role_arn = format("arn:aws:iam::%s:role/aws-service-role/ecs.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_ECSService",
#    data.aws_caller_identity.current.account_id)
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_autoscaling_policy" "cluster_policy_up" {
  name                   = "cluster-scale-up"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "SimpleScaling"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.cluster.name
}

resource "aws_autoscaling_policy" "cluster_policy_down" {
  name                   = "cluster-scale-down"
  scaling_adjustment     = -2
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "SimpleScaling"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.cluster.name
}