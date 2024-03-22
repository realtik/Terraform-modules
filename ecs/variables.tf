variable "ecs_cluster_config" {
  type = object({
    name          = string
    setting_name  = string
    setting_value = string

  })
}

variable "log_group_name" {
  type = string
}

variable "ecs_task_definition_config" {
  type = object({
    family                     = string
    network_mode               = string
    requires_compatibilities   = list(string)
    cpu                        = string
    memory                     = string
    operating_system_family    = string
    cpu_architecture           = string
    container_definitions_name = string
    image                      = string
    essential                  = bool
    containerPort              = string
    hostPort                   = string
    type                       = string
    awslogs-region             = string
    awslogs-stream-prefix      = string
  })
}

variable "ecs_service_config" {
  type = object({
    name                               = string
    launch_type                        = string
    platform_version                   = string
    desired_count                      = string
    deployment_minimum_healthy_percent = string
    deployment_maximum_percent         = string
    enable_ecs_managed_tags            = string
    propagate_tags                     = string
    assign_public_ip                   = string
    container_port                     = string
  })
}

variable "ecs_task_execution_role_arn" {
  type = string
}

variable "env_file_bucket_name" {
  type = string
}

variable "env_file_name" {
  type = string
}

variable "private-subnet-1_id" {
  type = string
}

variable "private-subnet-2_id" {
  type = string
}

variable "webserver_server_security_group_id" {
  type = string
}

variable "alb_target_group_arn" {
  type = string
}
