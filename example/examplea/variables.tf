variable "name" {
  type        = string
  description = "The name of the bastion server"

  validation {
    condition     = length(var.name) > 0
    error_message = "The name cannot be empty."
  }
}

variable "instance_type" {
  type        = string
  description = "The instance type for the bastion host"

  validation {
    condition     = length(var.instance_type) > 0
    error_message = "The instance_type cannot be empty."
  }
}
