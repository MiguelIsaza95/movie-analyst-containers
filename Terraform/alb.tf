resource "aws_lb" "ecs_cluster" {
  name               = "proxy"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_cluster_sg.id]
  subnets            = [aws_subnet.dmz_public.*.id]
  tags = {
    Environment = "Test"
  }
}

resource "aws_lb_target_group" "ecs_target" {
  name        = "ecs-instance-target"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.test.id
  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "80"
    protocol            = "HTTP"
    timeout             = 120
    healthy_threshold   = 5
    unhealthy_threshold = 3
    matcher = "200"
  }
}

resource "aws_lb_listener" "proxy" {
  load_balancer_arn = aws_lb.ecs_cluster.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_target.arn
  }
}