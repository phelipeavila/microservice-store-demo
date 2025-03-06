data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = [join("-", ["vpc", var.appname])]
  }
}

data "aws_subnets" "this" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
}

data "aws_subnet" "this" {
  for_each = toset(data.aws_subnets.this.ids)
  id       = each.value
}