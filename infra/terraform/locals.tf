locals {
  required_azs    = max(var.number_of_private_subnets, var.number_of_public_subnets, 1)
  azs             = sort(slice(data.aws_availability_zones.available.zone_ids, 0, local.required_azs))
  vpc_cidr        = "10.1.0.0/16"

  # Validate that at least one subnet is being created
  total_subnets = var.number_of_private_subnets + var.number_of_public_subnets
  validate_subnets = local.total_subnets > 0 ? true : tobool("At least one subnet (private or public) must be created")

  # Subnet CIDR calculations
  subnet_newbits  = 8  # Number of additional bits for subnet mask (/16 -> /24)
  
  # Generate private subnet CIDRs if requested
  private_subnet_cidrs = var.number_of_private_subnets > 0 ? [
    for i in range(var.number_of_private_subnets) : 
      cidrsubnet(local.vpc_cidr, local.subnet_newbits, i)
  ] : []

  # Generate public subnet CIDRs starting after private subnets
  public_subnet_cidrs = var.number_of_public_subnets > 0 ? [
    for i in range(var.number_of_public_subnets) : 
      cidrsubnet(local.vpc_cidr, local.subnet_newbits, i + var.number_of_private_subnets)
  ] : []
}