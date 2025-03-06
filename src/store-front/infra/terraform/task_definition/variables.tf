variable "task_config" {
  type = object({
    family                   = string
    execution_role_arn       = string
    task_role_arn            = string
    cpu                      = number
    memory                   = number
    network_mode             = string
    requires_compatibilities = list(string)
    container_name           = string
    image_uri                = string
    health_check_cmd         = string
    portMappings             = string
  })
}