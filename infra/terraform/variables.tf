variable "region" {
  description = "AWS region where the infrastructure will be deployed"
  type        = string
}

variable "appname" {
  description = "Name of the application, used for resource naming and tagging"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod) used for resource tagging"
  type        = string
}

variable "number_of_private_subnets" {
  description = "Number of private subnets to create across availability zones"
  type        = number
  default     = 1
  validation {
    condition     = var.number_of_private_subnets >= 0
    error_message = "The number_of_private_subnets value must be greater than or equal to 0."
  }
}

variable "number_of_public_subnets" {
  description = "Number of public subnets to create across availability zones"
  type        = number
  default     = 1
  validation {
    condition     = var.number_of_public_subnets >= 0
    error_message = "The number_of_public_subnets value must be greater than or equal to 0."
  }
}