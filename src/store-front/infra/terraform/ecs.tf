data "aws_ecs_cluster" "this" {
  cluster_name = join("-", ["ecs", var.appname])
}

module "ecs_service" {
  source   = "./service"

  service_config = {
    name                   = join("-",["sv", var.servicename])
    cluster_id             = data.aws_ecs_cluster.this.id
    capacity_provider_name = "FARGATE"
    task_definition_family = var.servicename
    desired_count          = 001

    load_balancer = {
      target_group_arn = module.lb_target.arn
      container_name   = var.servicename
      container_port   = module.lb_target.port
    }
    network = {
      security_groups = each.value.network.security_groups
      subnets         = sort([for subnet in data.aws_subnet.this : subnet.id if subnet.tags_all["Public"]])
    }
  }

  depends_on = [module.lb_target, aws_ecs_cluster.this]
}

module "load_balancer" {
  source = "./load_balancer"
  lb_config = {
    name   = join("-",["lb", var.servicename])
    vpc_id = data.aws_vpc.this.id
  }
}

module "lb_listener" {
  source   = "./load_balancer_listener"
  lb-listener-config = {
    lb-arn   = module.load_balancer.arn
    tg-arn   = module.lb_target.arn
    port     = "8080" ##tente colocar valor do module.lb_target
    protocol = "TCP" ##tente colocar valor do module.lb_target
  }

  depends_on = [module.load_balancer]

}

module "lb_target" {
  source   = "./load_balancer_target"
  tg_config = {
    name     = var.servicename
    port     = 8080
    protocol = "TCP"
    vpc_id   = data.aws_vpc.this.id
    health_check = {
      path    = "/health"
      matcher = 200
      port    = 80
    }
  }

  depends_on = [module.load_balancer]

}

module "task_definition" {
  source   = "./task_definition"
  task_config = {
    family                   = each.value.family
    execution_role_arn       = each.value.execution_role_arn
    task_role_arn            = each.value.task_role_arn
    cpu                      = each.value.cpu
    memory                   = each.value.memory
    network_mode             = each.value.network_mode
    requires_compatibilities = each.value.requires_compatibilities
    container_name           = each.value.container_name
    image_uri                = each.value.image_uri
    health_check_cmd         = each.value.health_check_cmd
    portMappings             = each.value.portMappings
  }
}