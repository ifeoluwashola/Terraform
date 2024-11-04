resource "aws_ecs_service" "ecs_service" {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = var.task_definition_arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  force_new_deployment = true

  triggers = {
    redeployment = plantimestamp()
  }

  desired_count = var.desired_count
}

output "service_name" {
  value = aws_ecs_service.ecs_service.name
}

output "service_arn" {
  value = aws_ecs_service.ecs_service.arn
}
