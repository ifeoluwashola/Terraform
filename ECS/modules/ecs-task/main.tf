resource "aws_ecs_task_definition" "app" {
  family                   = var.family
  network_mode             = "awsvpc"
  execution_role_arn       = var.execution_role_arn
  cpu                      = var.cpu
  memory                   = var.memory
  requires_compatibilities = ["FARGATE"]

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.image
      cpu       = var.cpu
      memory    = var.memory
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]
    }
  ])
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.app.arn
}
