resource "aws_lb_target_group" "this" {
  name        = var.tg_config.name
  port        = var.tg_config.port
  protocol    = var.tg_config.protocol
  target_type = "ip"
  vpc_id      = var.tg_config.vpc_id

  health_check {
    path                = var.tg_config.health_check.path
    matcher             = var.tg_config.health_check.matcher
    port                = var.tg_config.health_check.port
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }
}
