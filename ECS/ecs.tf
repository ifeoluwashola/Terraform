# resource "aws_ecs_cluster" "ecs-cluster" {
#   name = "ecs-cluster"

#   setting {
#     name  = "containerInsights"
#     value = "enabled"
#   }
# }

# resource "aws_ecs_task_definition" "app" {
#   family                   = "my-ecs-task"
#   network_mode             = "awsvpc"
#   execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
#   cpu                      = 256
#   memory                   = 512
#   requires_compatibilities = ["FARGATE"]
#   runtime_platform {
#     operating_system_family = "LINUX"
#     cpu_architecture        = "X86_64"
#   }
#   container_definitions = jsonencode([
#     {
#       name      = "nginx"
#       image     = "nginx"
#       cpu       = 256
#       memory    = 512
#       essential = true
#       portMappings = [
#         {
#           containerPort = 80
#           hostPort      = 80
#           protocol      = "tcp"
#         }
#       ]
#     }
#   ])
# }

# resource "aws_ecs_service" "ecs_service" {
#   name            = "ecs-service"
#   cluster         = aws_ecs_cluster.ecs-cluster.id
#   task_definition = aws_ecs_task_definition.app.arn
#   launch_type     = "FARGATE"

#   network_configuration {
#     subnets          = [aws_subnet.private.id] # Fargate tasks should run in private subnets
#     security_groups  = [aws_security_group.ecs_tasks.id]
#     assign_public_ip = false
#   }

#   load_balancer {
#     target_group_arn = aws_lb_target_group.alb-tg.arn
#     container_name   = "nginx"
#     container_port   = 80
#   }

#   force_new_deployment = true

#   triggers = {
#     redeployment = plantimestamp()
#   }

#   desired_count = 1
#   depends_on    = [aws_iam_role_policy_attachment.ecs_task_execution_role, aws_lb_listener.https_forward]
# }
