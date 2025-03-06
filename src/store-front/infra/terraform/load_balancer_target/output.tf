output "arn" {
  value = aws_lb_target_group.this.arn
}

output "port" {
  value = aws_lb_target_group.this.port
}