# export the ecs service
output "ecs_service" {
  value = aws_ecs_service.ecs_service
}

# export ecs cluster name
output "ecs_cluster_name" {
  value = var.ecs_cluster_config.name
}

# export ecs service name 
output "ecs_service_name" {
  value = var.ecs_service_config.name
}