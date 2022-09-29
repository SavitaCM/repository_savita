module "vpc" {
  source    = "../network_module"
  namespace = var.namespace
}

resource "aws_lb" "sampleapp_alb" {
  name               = "sampleapp-alb-${var.namespace}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.sg_pub_id}"]
  subnets            = var.vpc.public_subnets

  enable_deletion_protection = true


  tags = {
    name = "${var.namespace}-alb"
  }
}

resource "aws_lb_target_group" "sampleapp_http_tg" {
  name     = "sampleapp-http-tg-${var.namespace}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc.vpc_id

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 4
    timeout             = 4
    interval            = 5
  }
}


resource "aws_lb_listener" "http_listener_80" {
  load_balancer_arn = aws_lb.sampleapp_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sampleapp_http_tg.arn
  }
}
