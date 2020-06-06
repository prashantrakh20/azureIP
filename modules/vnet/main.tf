resource "azurerm_virtual_network" "azip_vnet" {
    name                = var.vnet_name
    address_space       = ["192.168.0.0/24"]
    location            = var.vnet_location
    resource_group_name = var.rsgp_name

 
    tags = {
        environment = var.vnet_tag
    }
}

resource "azurerm_subnet" "azip_subnet" {
    name                 = var.subnet_name
    resource_group_name  = var.rsgp_name
    virtual_network_name = var.vnet_name
    address_prefixes       = ["192.168.0.0/26"]
    

}



output "sub_id" {
  value = azurerm_subnet.azip_subnet.id
}

