variable "ecs_config" {
  type = object({
    cluster = object({
      name  = string
    })
  })
}