provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.2.0"
  subscription_id = "89de6f49-7f6e-4e5a-bdd6-b56952bb56a2"
  features {}

}

resource "azurerm_resource_group" "example_rg" {
  name     = var.res_name
  location = "West Europe"
}

resource "azurerm_virtual_network" "example_vn" {
  name                = var.virtual_net
  resource_group_name = azurerm_resource_group.example_rg.name
  location            = azurerm_resource_group.example_rg.location
  address_space       = ["10.0.0.0/16"]
}