output "dns_name" {
  value = aws_lb.this.dns_name
}

output "eip" {
  value = aws_eip.this
}

output "arn" {
  value = aws_lb.this.arn
}