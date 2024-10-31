resource "aws_security_group" "lb_sg" {
  vpc_id      = var.vpc_id
  name        = var.lb_sg_name
  description = "controls access to the Application Load Balancer (ALB)"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.lb_sg_name
  }
}

resource "aws_security_group" "ecs_tasks_sg" {
  vpc_id      = var.vpc_id
  name        = var.ecs_tasks_sg_name
  description = "allow inbound access from the ALB only"

  ingress {
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
    security_groups = [aws_security_group.lb_sg.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.ecs_tasks_sg_name
  }
}

output "lb_sg_id" {
  value = aws_security_group.lb_sg.id
}

output "ecs_tasks_sg_id" {
  value = aws_security_group.ecs_tasks_sg.id
}
