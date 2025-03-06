resource "aws_lb" "this" {
  name                             = var.lb_config.name
  internal                         = false
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true

  dynamic "subnet_mapping" {
    for_each = toset(local.public_subnet_names)
    content {
      allocation_id = aws_eip.this[subnet_mapping.key].id
      subnet_id     = local.public_subnet_map[subnet_mapping.key].id
    }
  }

  depends_on = [
    aws_eip.this
  ]
}

# module "tg_backend" {
#   source       = "./target-group"
#   tg-config = {
#     name = "tg-itbuzz-backend"
#     port = "5050"
#     protocol = "TCP"
#     vpc-id = var.lb_config.vpc_id
#     health_check = {
#       path = "/api/version"
#       matcher = "200"
#     }
#   }
# }

# module "itbuzz-lb-listener" {
#   source       = "./lb-listener"
#   lb-listener-config = {
#     lb-arn     = aws_lb.this.arn
#     tg-arn     = module.tg_backend.arn
#     port       = "5050"
#     protocol   = "TCP"
#   }
# }
