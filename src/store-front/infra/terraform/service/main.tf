resource "aws_ecs_service" "this" {
  name                               = var.service_config.name
  cluster                            = var.service_config.cluster_id
  task_definition                    = var.service_config.task_definition_family
  desired_count                      = var.service_config.desired_count
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 300
  enable_execute_command             = true
  scheduling_strategy                = "REPLICA"
  health_check_grace_period_seconds  = 300
  #platform_version                   = var.service_config.capacity_provider_name == "FARGATE" ? "LATEST" : null

  capacity_provider_strategy {
    base              = 0
    weight            = 1
    capacity_provider = var.service_config.capacity_provider_name
  }

  deployment_controller {
    type = "ECS"
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  network_configuration {
    security_groups  = var.service_config.network.security_groups
    subnets          = var.service_config.network.subnets
    assign_public_ip = var.service_config.capacity_provider_name == "FARGATE" ? true : null
  }

  load_balancer {
    target_group_arn = var.service_config.load_balancer.target_group_arn
    container_name   = var.service_config.load_balancer.container_name
    container_port   = var.service_config.load_balancer.container_port
  }


  dynamic "ordered_placement_strategy" {
    for_each = var.service_config.capacity_provider_name == "FARGATE" ? [] : [1]
    content {
      type  = "spread"
      field = "instanceId"
    }
  }


  #  lifecycle {
  #   ignore_changes = [ task_definition ]
  # #   ignore_changes = ["desired_count"]
  #  }
}
