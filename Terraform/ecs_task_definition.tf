resource "aws_ecs_task_definition" "proxy" {
  task_role_arn         = aws_iam_role.cluster_task_role.arn
  container_definitions = file("${path.module}/task_definition/proxy.json")
}

resource "aws_ecs_task_definition" "ui" {
  task_role_arn         = aws_iam_role.cluster_task_role.arn
  container_definitions = file("${path.module}/task_definition/ui.json")
}

resource "aws_ecs_task_definition" "api" {
  task_role_arn         = aws_iam_role.cluster_task_role.arn
  container_definitions = file("${path.module}/task_definition/api.json")
}