module "ecs-cluster" {
  source = "./ecs"
  ecs_config = {
    cluster = {
      name  = join("-", ["ecs", var.appname])
    }
  }
}