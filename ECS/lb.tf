# resource "aws_lb" "alb" {
#   name               = "alb"
#   subnets            = [aws_subnet.public.id, aws_subnet.public2.id]
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.lb_sg.id]

#   tags = {
#     Name = "alb"
#   }
# }

# resource "aws_lb_listener" "https_forward" {
#   load_balancer_arn = aws_lb.alb.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.alb-tg.arn
#   }
# }

# resource "aws_lb_target_group" "alb-tg" {
#   name        = "alb-tg"
#   port        = 80
#   protocol    = "HTTP"
#   vpc_id      = aws_vpc.main.id
#   target_type = "ip"

#   health_check {
#     healthy_threshold   = "3"
#     interval            = "90"
#     protocol            = "HTTP"
#     matcher             = "200-299"
#     timeout             = "20"
#     path                = "/"
#     unhealthy_threshold = "2"
#   }
# }