resource "aws_ecs_cluster" "movieanalyst" {
  name = "movieapp"
}

resource "aws_ecs_capacity_provider" "cluster_capacity" {
  name = "test"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.cluster.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 5
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 80
    }
  }
}