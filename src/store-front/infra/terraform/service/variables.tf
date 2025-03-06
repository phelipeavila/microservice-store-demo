variable "service_config" {
  type = object({
    name                   = string
    cluster_id             = string
    capacity_provider_name = string
    task_definition_family = string
    desired_count          = number

    load_balancer = object({
      target_group_arn = string
      container_name   = string
      container_port   = number
    })
    network = object({
      security_groups = list(string)
      subnets         = list(string)
    })
  })
}