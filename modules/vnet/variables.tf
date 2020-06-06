variable "rsgp_name" {
    type = string
  }

variable "vnet_name" {
  description = "vnet name"
  type        = string
}

variable "vnet_location" {
  description = "vnet location"
  type        = string
}

variable "vnet_tag" {
  description = "vnet tag"
  type        = string
}

variable "subnet_name" {
  type = string
}
