resource "azurerm_resource_group" "azip_rsgp" {
    name     = var.rsgp_name
    location = var.rsgp_location

    tags = {
        environment = var.rsgp_tag
    }
}

