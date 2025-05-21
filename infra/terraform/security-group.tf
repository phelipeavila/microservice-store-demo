module "sg_database" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "database-node"
  description = "Security group for database node"
  vpc_id      = module.vpc.vpc_id

  egress_rules = ["all-all"]
  ingress_with_source_security_group_id = [
    {
      rule                     = "postgresql-tcp"
      source_security_group_id = module.sg_backend.security_group_id
    },
    # {
    #   # rule                     = "ssh-tcp"
    #   # source_security_group_id = aws_security_group.sg_control_node.id
    # },
  ]
  tags = {
    yor_name  = "sg_database"
    yor_trace = "4a6f4c4d-3913-45ea-ae4a-dc65bd468355"
  }
}

module "sg_backend" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "backend-node"
  description = "Security group for backend node"
  vpc_id      = module.vpc.vpc_id

  egress_rules = ["all-all"]
  # ingress_with_source_security_group_id = [
  #   {
  #     # rule                     = "ssh-tcp"
  #     # source_security_group_id = aws_security_group.sg_control_node.id
  #   },
  # ]
  ingress_with_cidr_blocks = [
    {
      from_port   = 3333
      to_port     = 3333
      protocol    = "tcp"
      description = "Allow access to backend app"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  tags = {
    yor_name  = "sg_backend"
    yor_trace = "d962ad9e-6a20-408e-8482-849ee4e7e1cf"
  }
}

module "sg_frontend" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "frontend-node"
  description = "Security group for frontend nodes"
  vpc_id      = module.vpc.vpc_id

  egress_rules = ["all-all"]
  # ingress_with_source_security_group_id = [
  #   {
  #     # rule                     = "ssh-tcp"
  #     # source_security_group_id = aws_security_group.sg_control_node.id
  #   },
  # ]
  ingress_with_cidr_blocks = [
    {
      from_port   = 3035
      to_port     = 3035
      protocol    = "tcp"
      description = "Allow access to frontend app"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  tags = {
    yor_name  = "sg_frontend"
    yor_trace = "e633b84c-0d26-43a2-99b9-5da602782f1b"
  }
}

