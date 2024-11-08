ecs_cluster_name            = "ecs-cluster"
task_family                 = "my-ecs-task"
task_memory                 = 512
task_cpu                    = 256
vpc_cidr                    = "10.0.0.0/16"
aws_region                  = "us-east-1"
alb_name                    = "alb"
alb_listener_port           = 80
alb_listener_protocol       = "HTTP"
health_check_path           = "/"
desired_count               = 0
ecs_task_role_name          = "ecsTaskRole"
ecs_task_execution_role_name = "ecs-execution-role"
task_image = "nginx"
container_port = 80
service_name = "ecs-service"
container_name = "nginx"
private_subnet_cidrs = ["10.0.105.0/24"]
public_subnet_cidrs = [ "10.0.101.0/24", "10.0.102.0/24" ]
availability_zones = [ "us-east-1a", "us-east-1b" ]
public_route_table_name = "public-route-table"
private_route_table_name = "private-route-table"
vpc_name = "ecs-main-vpc"
igw_name = "main-igw"
lb_sg_name = "ecs-lb-sg"
ecs_tasks_sg_name = "ecs-tasks-sg"