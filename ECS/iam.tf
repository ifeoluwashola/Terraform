# data "aws_iam_policy_document" "ecs_task_execution_role" {
#   version = "2012-10-17"
#   statement {
#     sid     = ""
#     effect  = "Allow"
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ecs-tasks.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role" "ecs_task_execution_role" {
#   name               = "ecs-staging-execution-role"
#   assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
# }

# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }


# resource "aws_iam_role" "ecs_task_role" {
#   name = "ecsTaskRole"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect = "Allow",
#       Principal = {
#         Service = "ecs-tasks.amazonaws.com"
#       },
#       Action = "sts:AssumeRole"
#     }]
#   })

#   tags = {
#     Name = "ecs-task-role"
#   }
# }

# # Attach S3 and DynamoDB access policies to the ECS Task Role
# resource "aws_iam_role_policy_attachment" "s3_access" {
#   role       = aws_iam_role.ecs_task_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
# }

# resource "aws_iam_role_policy_attachment" "dynamodb_access" {
#   role       = aws_iam_role.ecs_task_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
# }