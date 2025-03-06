resource "aws_lb_listener" "this" {
  load_balancer_arn = var.lb-listener-config.lb-arn
  port              = var.lb-listener-config.port
  protocol          = var.lb-listener-config.protocol

  default_action {
    type             = "forward"
    target_group_arn = var.lb-listener-config.tg-arn
  }
}