resource "aws_ecs_task_definition" "proxy" {
  family                   = "proxy"
  container_definitions    = file("${path.module}/task_definition/proxy.json")
  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  task_role_arn            = aws_iam_role.cluster_instance_role.arn
  execution_role_arn       = aws_iam_role.cluster_task_role.arn
}

resource "aws_ecs_task_definition" "ui" {
  family                   = "frontend"
  container_definitions    = file("${path.module}/task_definition/ui.json")
  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  task_role_arn            = aws_iam_role.cluster_instance_role.arn
  execution_role_arn       = aws_iam_role.cluster_task_role.arn
}

resource "aws_ecs_task_definition" "api" {
  family                   = "backend"
  container_definitions    = file("${path.module}/task_definition/api.json")
  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  task_role_arn            = aws_iam_role.cluster_instance_role.arn
  execution_role_arn       = aws_iam_role.cluster_task_role.arn
}