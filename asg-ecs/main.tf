# create an auto scaling group for the ecs service
resource "aws_appautoscaling_target" "ecs_asg" {
  max_capacity       = var.ecs_asg_config.max_capacity
  min_capacity       = var.ecs_asg_config.min_capacity
  resource_id        = "service/${var.ecs_cluster_name}-cluster/${var.ecs_service_name}-service"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  depends_on = [var.ecs_service]
}

# create scaling policy for the auto scaling group
resource "aws_appautoscaling_policy" "ecs_policy" {
  name               = "${var.ecs_policy_config.name}-policy"
  policy_type        = var.ecs_policy_config.policy_type
  resource_id        = "service/${var.ecs_cluster_name}-cluster/${var.ecs_service_name}-service"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  
  target_tracking_scaling_policy_configuration {

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = var.ecs_policy_config.target_value
    scale_out_cooldown = var.ecs_policy_config.scale_out_cooldown
    scale_in_cooldown  = var.ecs_policy_config.scale_in_cooldown
    disable_scale_in   = var.ecs_policy_config.disable_scale_in
  }

  depends_on = [aws_appautoscaling_target.ecs_asg]
}