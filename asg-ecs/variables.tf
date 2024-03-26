variable "ecs_asg_config" {
  type = object({
  max_capacity       = number
  min_capacity       = number
  })
}

variable "ecs_policy_config" {
  type = object({
  name               = string
  policy_type        = string
  target_value       = number
  scale_out_cooldown = number
  scale_in_cooldown  = number
  disable_scale_in   = string
  })
}

variable "ecs_cluster_name" {
  type = string
}

variable "ecs_service_name" {
  type = string
}

variable "ecs_service" {
  type = string
}