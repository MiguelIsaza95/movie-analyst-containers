resource "aws_ecs_service" "proxy-ecs-service" {
  	name            = "Movie service"
  	iam_role        = aws_iam_role.cluster_service_role.arn
  	cluster         = aws_ecs_cluster.movieanalyst.id
  	task_definition = aws_ecs_task_definition.mesh-sample-definition.arn
  	desired_count   = 1

  	load_balancer {
    	target_group_arn  = aws_lb.ecs_cluster.arn
    	container_port    = 80
    	container_name    = "simple-app"
	}
}

resource "aws_ecs_service" "ui-ecs-service" {
  	name            = "Movie service"
  	iam_role        = aws_iam_role.cluster_service_role.arn
  	cluster         = aws_ecs_cluster.movieanalyst.id
  	task_definition = aws_ecs_task_definition.mesh-sample-definition.arn
  	desired_count   = 1

  	load_balancer {
    	target_group_arn  = aws_lb.ecs_cluster.arn
    	container_port    = 80
    	container_name    = "simple-app"
	}
}

resource "aws_ecs_service" "api-ecs-service" {
  	name            = "Movie service"
  	iam_role        = aws_iam_role.cluster_service_role.arn
  	cluster         = aws_ecs_cluster.movieanalyst.id
  	task_definition = aws_ecs_task_definition.mesh-sample-definition.arn
  	desired_count   = 1

  	load_balancer {
    	target_group_arn  = aws_lb.ecs_cluster.arn
    	container_port    = 80
    	container_name    = "simple-app"
	}
}