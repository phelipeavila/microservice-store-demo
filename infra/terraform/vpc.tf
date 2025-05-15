module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = join("-", ["vpc", var.appname])
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = local.private_subnet_cidrs
  public_subnets  = local.public_subnet_cidrs

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Application = var.appname
  }
  
  public_subnet_tags = {
    "Public" = "true"
  }
}