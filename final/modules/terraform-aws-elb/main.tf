resource "aws_lb" "this" {
  name            = var.name
  subnets         = var.public_subnet_ids
  internal        = var.internal
  load_balancer_type = "application"
  security_groups = [var.autoscaling_security_group_id]

  enable_cross_zone_load_balancing   = var.cross_zone_load_balancing
  idle_timeout                       = var.idle_timeout

  tags = {
    Name = "elb"
  }
}

resource "aws_lb_target_group" "this" {
  name        = "lb-tg-80"
  port        = 80
  protocol    = "HTTP"
  slow_start  = 60
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200,202"
    protocol            = "HTTP"
    path                = "/actuator/health"
    port                = 80
    interval            = 30
    timeout             = 10
  }

  depends_on = [aws_lb.this]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_elb" {
  autoscaling_group_name = var.autoscaling_group_id
  alb_target_group_arn   = aws_lb_target_group.this.arn
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  lifecycle {
    create_before_destroy = true
  }
}
