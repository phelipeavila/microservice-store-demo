resource "aws_ecs_cluster" "this" {
  name = var.ecs_config.cluster.name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }
  tags = {
    yor_name  = "this"
    yor_trace = "a7d9c0f8-0fcf-4108-815a-8fe3f61d9317"
  }
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name       = aws_ecs_cluster.this.name
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    base              = 0
    weight            = 1
    capacity_provider = "FARGATE"
  }
}