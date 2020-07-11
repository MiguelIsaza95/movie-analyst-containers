resource "aws_autoscaling_group" "cluster" {
  name_prefix               = "cluster-autoscaling-group"
  max_size                  = 5
  min_size                  = 3
  health_check_grace_period = 300
  health_check_type         = "EC2"
  default_cooldown          = 300
  termination_policies      = ["Default"]
  enabled_metrics           = var.enabled_metrics
  protect_from_scale_in     = false
  target_group_arns         = [aws_alb_target_group.cluster_target.arn]
  vpc_zone_identifier       = aws_subnet.cluster_private.*.id
  launch_template {
    id      = aws_launch_template.cluster_conf.id
    version = "$Latest"
  }
  force_delete = true
  lifecycle {
    create_before_destroy = true
  }
}