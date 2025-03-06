variable "lb-listener-config" {
  type = object({
    lb-arn   = string
    tg-arn   = string
    port     = string
    protocol = string
  })
}