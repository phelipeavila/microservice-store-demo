resource "aws_ecs_task_definition" "this" {
  family             = var.task_config.family
  execution_role_arn = var.task_config.execution_role_arn
  task_role_arn      = var.task_config.task_role_arn
  # family                   = "task-itbuzz-backend"
  # execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
  # task_role_arn            = data.aws_iam_role.ecs_task_execution_role.arn
  network_mode             = var.task_config.network_mode
  requires_compatibilities = var.task_config.requires_compatibilities
  cpu                      = var.task_config.cpu
  memory                   = var.task_config.memory
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = <<DEFINITION
[
            {
                "name": "${var.task_config.container_name}",
                "image": "${var.task_config.image_uri}",
                "cpu": 0,
                "portMappings": [${var.task_config.portMappings}],
                "essential": true,
                "linuxParameters": {
                  "initProcessEnabled": true
                },
                "environment": [],
                "environmentFiles": [],
                "mountPoints": [],
                "volumesFrom": [],
                "logConfiguration": {
                    "logDriver": "awslogs",
                    "options": {
                        "awslogs-create-group": "true",
                        "awslogs-group": "/ecs/${var.task_config.container_name}",
                        "awslogs-region": "us-east-1",
                        "awslogs-stream-prefix": "ecs"
                    }
                },
                "healthCheck": {
                    "command": [
                        "CMD-SHELL",
                        "${var.task_config.health_check_cmd}"
                    ],
                    "interval": 30,
                    "timeout": 5,
                    "retries": 3,
                    "startPeriod": 300
                }
            }
]
DEFINITION
}
