resource "aws_lb" "myajay_lb" {
  name                       = "myajay-lb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.myajay_ha_sg.id]
  subnets                    = var.subnet_ids
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "myajay_tg" {
  name        = "myajay-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    port                = 80
  }
}

resource "aws_lb_listener" "myajay_lb_listener_http" {
  load_balancer_arn = aws_lb.myajay_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.myajay_tg.arn
  }

}