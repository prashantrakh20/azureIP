variable "name" {
    description = "name of resources"
    type = string
    default = "devres"

  }

variable "location" {
  description = "location"
  type        = string
  default = "eastus"
}

variable "tag" {
    type = string
    default = "dev"

}