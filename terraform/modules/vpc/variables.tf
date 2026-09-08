variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "availability_zones" {
  type = list(string)

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "At least 2 availability zones are required."
  }
}

variable "public_subnets" {
  type = map(object({
    az   = string
    cidr = string
  }))

  validation {
    condition = alltrue([
      for subnet in values(var.public_subnets) :
      contains(var.availability_zones, subnet.az)
    ])

    error_message = "Every public subnet AZ must exist in availability_zones."
  }
}

variable "private_subnets" {
  type = map(object({
    az   = string
    cidr = string
  }))

  validation {
    condition = alltrue([
      for subnet in values(var.private_subnets) :
      contains(var.availability_zones, subnet.az)
    ])

    error_message = "Every private subnet AZ must exist in availability_zones."
  }
}

variable "nat_subnet_name" {
  type = string

  validation {
    condition     = contains(keys(var.public_subnets), var.nat_subnet_name)
    error_message = "nat_subnet_name must reference an existing public subnet."
  }
}