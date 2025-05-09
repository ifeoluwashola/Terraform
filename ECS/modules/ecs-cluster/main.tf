resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = var.container_insights_enabled ? "enabled" : "disabled"
  }
}

output "cluster_id" {
  value = aws_ecs_cluster.ecs_cluster.id
}

output "cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}
