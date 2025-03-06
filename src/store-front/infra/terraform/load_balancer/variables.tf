variable "lb_config" {
  type = object({
    name   = string
    vpc_id = string
  })
}

