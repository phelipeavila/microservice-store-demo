module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = join("-", ["vpc", var.appname])
  cidr = "10.1.0.0/16"

  azs             = ["us-west-2a"]
  #private_subnets = ["10.0.1.0/25"]
  public_subnets  = ["10.1.1.128/25"]

  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = {
    Terraform   = "true"
    Environment = var.environment
    Application = var.appname
  }
}