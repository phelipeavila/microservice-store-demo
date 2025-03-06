variable "tg_config" {
  type = object({
    name     = string
    port     = string
    protocol = string
    vpc_id   = string
    health_check = object({
      path    = string
      matcher = string
      port    = string
    })
  })
}