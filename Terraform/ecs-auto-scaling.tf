resource "aws_appautoscaling_target" "proxy" {
  depends_on   = [aws_appautoscaling_target.ui]
  max_capacity = 5
  min_capacity = 1
  resource_id  = "service/${aws_ecs_cluster.movieanalyst}/proxy"
  role_arn = format("arn:aws:iam::%s:role/aws-service-role/ecs.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_ECSService",
  data.aws_caller_identity.current.account_id)

  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs_proxy"
}

resource "aws_appautoscaling_policy" "proxy_policy_up" {
  name               = "proxy-scale-up"
  resource_id        = aws_appautoscaling_target.proxy.resource_id
  scalable_dimension = aws_appautoscaling_target.proxy.scalable_dimension
  service_namespace  = aws_appautoscaling_target.proxy.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 1.0
      scaling_adjustment          = 1
    }
  }
}

resource "aws_appautoscaling_policy" "proxy_policy_down" {
  name               = "proxy-scale-up"
  resource_id        = aws_appautoscaling_target.proxy.resource_id
  scalable_dimension = aws_appautoscaling_target.proxy.scalable_dimension
  service_namespace  = aws_appautoscaling_target.proxy.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"
    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}

resource "aws_appautoscaling_target" "ui" {
  max_capacity = 5
  min_capacity = 1
  resource_id  = "service/${aws_ecs_cluster.movieanalyst}/ui"
  role_arn = format("arn:aws:iam::%s:role/aws-service-role/ecs.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_ECSService",
  data.aws_caller_identity.current.account_id)

  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs_ui"
}

resource "aws_appautoscaling_policy" "ui_policy_up" {
  name               = "ui-scale-up"
  resource_id        = aws_appautoscaling_target.ui.resource_id
  scalable_dimension = aws_appautoscaling_target.ui.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ui.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 1.0
      scaling_adjustment          = 1
    }
  }
}

resource "aws_appautoscaling_policy" "ui_policy_down" {
  name               = "ui-scale-up"
  resource_id        = aws_appautoscaling_target.ui.resource_id
  scalable_dimension = aws_appautoscaling_target.ui.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ui.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"
    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}

resource "aws_appautoscaling_target" "api" {
  max_capacity = 5
  min_capacity = 1
  resource_id  = "service/${aws_ecs_cluster.movieanalyst}/api"
  role_arn = format("arn:aws:iam::%s:role/aws-service-role/ecs.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_ECSService",
  data.aws_caller_identity.current.account_id)

  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs_api"
}

resource "aws_appautoscaling_policy" "api_policy_up" {
  name               = "api-scale-up"
  resource_id        = aws_appautoscaling_target.api.resource_id
  scalable_dimension = aws_appautoscaling_target.api.scalable_dimension
  service_namespace  = aws_appautoscaling_target.api.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 1.0
      scaling_adjustment          = 1
    }
  }
}

resource "aws_appautoscaling_policy" "api_policy_down" {
  name               = "api-scale-up"
  resource_id        = aws_appautoscaling_target.api.resource_id
  scalable_dimension = aws_appautoscaling_target.api.scalable_dimension
  service_namespace  = aws_appautoscaling_target.api.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"
    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}