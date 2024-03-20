variable "ecs_task_execution_role_config" {
  type = object({
    name = string
  })
}


variable "env_file_bucket_name" {
  type = string
}
