resource "aws_autoscaling_attachment" "asg_attachment_elb" {
  autoscaling_group_name = var.autoscaling_group_id
  elb                    = aws_elb.this.id
}

resource "aws_elb" "this" {
  name            = var.name
  subnets         = var.public_subnet_ids
  internal        = var.internal

  //security_groups = var.security_groups
  //instances                   = [module.asg.autoscaling_group_id]

  cross_zone_load_balancing   = var.cross_zone_load_balancing
  idle_timeout                = var.idle_timeout
  connection_draining         = var.connection_draining
  connection_draining_timeout = var.connection_draining_timeout

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    target              = "HTTP:80/actuator/health"
    interval            = 30
    timeout             = 30
  }

  tags = {
    Name = "elb"
  }
}
