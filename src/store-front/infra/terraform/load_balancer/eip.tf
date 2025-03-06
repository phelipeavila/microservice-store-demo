resource "aws_eip" "this" {
  for_each = toset(local.public_subnet_names)
  vpc      = true
}