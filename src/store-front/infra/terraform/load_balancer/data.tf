data "aws_subnets" "this" {
  filter {
    name   = "vpc-id"
    values = [var.lb_config.vpc_id]
  }
}

data "aws_subnet" "this" {
  for_each = toset(data.aws_subnets.this.ids)
  id       = each.value
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.lb_config.vpc_id]
  }

  filter {
    name   = "tag:Public"
    values = ["true"]
  }
}

data "aws_subnet" "public" {
  for_each = toset(data.aws_subnets.public.ids)
  id       = each.value
}

locals {
  all_subnet_ids      = toset(data.aws_subnets.this.ids)
  all_subnet_map      = { for subnet in data.aws_subnet.this : subnet.tags["Name"] => subnet }
  public_subnet_names = sort([for subnet in data.aws_subnet.this : subnet.tags["Name"] if subnet.tags["Public"] == "true"])
  public_subnet_map   = { for subnet in data.aws_subnet.public : subnet.tags["Name"] => subnet }
}