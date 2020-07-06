resource "aws_lb" "proxy_service" {
  name               = "proxy"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_proxy_sg.id]
  subnets            = [aws_subnet.dmz_public.*.id]
  tags = {
    Environment = "Test"
  }
}

resource "aws_lb_target_group" "proxy_target" {
  name        = "tf-example-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.test.id
  health_check {
    enabled           = true
    interval          = 30
    path              = "/"
    port              = "80"
    protocol          = "HTTP"
    timeout           = 120
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher           = ["200,202"]
  }
}

resource "aws_lb_listener" "proxy" {
  load_balancer_arn = aws_lb.proxy_service.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.proxy_target.arn
  }
}