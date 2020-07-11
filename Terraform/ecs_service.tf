resource "aws_ecs_service" "proxy_ecs_service" {
  name            = "Movie service"
  iam_role        = aws_iam_role.cluster_service_role.arn
  cluster         = aws_ecs_cluster.movieanalyst.id
  task_definition = aws_ecs_task_definition.proxy.arn
  desired_count   = 3
  launch_type     = "EC2"

  load_balancer {
    target_group_arn = aws_lb.ecs_cluster.arn
    container_port   = 80
    container_name   = "movie-analyst-proxy"
  }

  network_configuration {
    assign_public_ip = false
    subnets          = aws_subnet.clusterprivate.*.id
  }
}

resource "aws_ecs_service" "ui_ecs_service" {
  name            = "Movie service"
  iam_role        = aws_iam_role.cluster_service_role.arn
  cluster         = aws_ecs_cluster.movieanalyst.id
  task_definition = aws_ecs_task_definition.ui.arn
  desired_count   = 3
  launch_type     = "EC2"

  network_configuration {
    assign_public_ip = false
    subnets          = aws_subnet.clusterprivate.*.id
  }
}

resource "aws_ecs_service" "api_ecs_service" {
  name            = "Movie service"
  iam_role        = aws_iam_role.cluster_service_role.arn
  cluster         = aws_ecs_cluster.movieanalyst.id
  task_definition = aws_ecs_task_definition.api.arn
  desired_count   = 3
  launch_type     = "EC2"

  network_configuration {
    assign_public_ip = false
    subnets          = aws_subnet.clusterprivate.*.id
  }
}