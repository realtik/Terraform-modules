# create ecs cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.ecs_cluster_config.name}-cluster"

  setting {
    name  = var.ecs_cluster_config.setting_name
    value = var.ecs_cluster_config.setting_value
  }
}

# create cloudwatch log group
resource "aws_cloudwatch_log_group" "log_group" {
  name = "/ecs/${var.log_group_name}-td"

  lifecycle {
    create_before_destroy = true
  }
}

# create task definition
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "${var.ecs_task_defintion_config.family}-td"
  execution_role_arn       = var.ecs_task_execution_role_arn
  network_mode             = var.ecs_task_definition_config.network_mode
  requires_compatibilities = var.ecs_task_definition_config.requires_compatibilities
  cpu                      = var.ecs_task_definition_config.cpu
  memory                   = var.ecs_task_definition_config.memory

  runtime_platform {
    operating_system_family = var.ecs_task_definition_config.operating_system_family
    cpu_architecture        = var.ecs_task_definition_config.cpu_architecture
  }

  # create container definition
  container_definitions = jsonencode([
    {
      name      = "${var.ecs_task_definition_config.container_definitions_name}-container"
      image     = "${var.ecs_task_definition_config.image}"
      essential = "${var.ecs_task_definition_config.essential}"

      portMappings = [
        {
          containerPort = "${var.ecs_task_definition_config.containerPort}"
          hostPort      = "${var.ecs_task_definition_config.hostPort}"
        }
      ]

      environmentFiles = [
        {
          value = "arn:aws:s3:::${var.env_file_bucket_name}/${var.env_file_name}"
          type  = "${var.ecs_task_definition_config.type}"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = "${aws_cloudwatch_log_group.log_group.name}",
          "awslogs-region"        = "${var.ecs_task_definition_config.awslogs-region}",
          "awslogs-stream-prefix" = "${var.ecs_task_definition_config.awslogs-stream-prefix}"
        }
      }
    }
  ])
}

# create ecs service
resource "aws_ecs_service" "ecs_service" {
  name                               = "${var.ecs_service_config.name}-service"
  launch_type                        = var.ecs_service_config.launch_type
  cluster                            = aws_ecs_cluster.ecs_cluster.id
  task_definition                    = aws_ecs_task_definition.ecs_task_definition.arn
  platform_version                   = var.ecs_service_config.platform_version
  desired_count                      = var.ecs_service_config.desired_count
  deployment_minimum_healthy_percent = var.ecs_service_config.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.ecs_service_config.deployment_maximum_percent

  # task tagging configuration
  enable_ecs_managed_tags = var.ecs_service_config.enable_ecs_managed_tags
  propagate_tags          = var.ecs_service_config.propagate_tags

  # vpc and security groups
  network_configuration {
    subnets          = [var.private-subnet-1_id, var.private-subnet-2_id]
    security_groups  = [var.webserver_server_security_group_id]
    assign_public_ip = var.ecs_service_config.assign_public_ip
  }

  # load balancing
  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "${var.ecs_task_definition_config.container_definitions_name}-container"
    container_port   = var.ecs_service_config.container_port
  }
}
