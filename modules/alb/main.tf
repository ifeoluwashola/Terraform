resource "aws_lb" "alb" {
  name               = var.lb_name
  subnets            = var.subnets
  load_balancer_type = var.lb_type
  security_groups    = var.security_groups

  tags = {
    Name = var.lb_name
  }
}

resource "aws_lb_listener" "https_forward" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}

output "alb_arn" {
  value = aws_lb.alb.arn
}

output "https_forward_listener_arn" {
  value = aws_lb_listener.https_forward.arn
}
