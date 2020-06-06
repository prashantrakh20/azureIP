resource "azurerm_network_security_group" "azip_nsgp" {
    name                = var.nsgp_name
    location            = var.nsgp_location
    resource_group_name = var.rsgp_name
    
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = var.ssh_port_no
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = var.rsgp_tag
        }

}



resource "azurerm_network_interface" "azip_ani" {
    name                      = "myani"
    location                  = var.nsgp_location
    resource_group_name       = var.rsgp_name

    ip_configuration {
        name                          ="myaniconfiguration" 
        subnet_id                     = var.subn_id
        private_ip_address_allocation = "static"
        private_ip_address = "192.168.0.50"
     }

    tags = {
        environment = var.rsgp_tag
    }
}
resource "azurerm_network_interface_security_group_association" "azip_nisga" {
    network_security_group_id = azurerm_network_security_group.azip_nsgp.id
    network_interface_id = azurerm_network_interface.azip_ani.id

}




resource "tls_private_key" "key_ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}
output "tls_private_key" { value = "${tls_private_key.key_ssh.private_key_pem}" }



resource "azurerm_linux_virtual_machine" "azip_vm" {
    name                  = "myVM"
    location              = "eastus"
    resource_group_name   = var.rsgp_name
    network_interface_ids = [azurerm_network_interface.azip_ani.id]
    size                  = "Standard_DS1_v2"

    os_disk {
        name              = "myOsDisk"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }

    computer_name  = "mylinuxvm"
    admin_username = "einfochips"
    disable_password_authentication = true
            
    admin_ssh_key {
        username       = "einfochips"
        public_key     = tls_private_key.key_ssh.public_key_openssh
    }

    tags = {
        environment = "var.rsgp_tag"
    }
}

output "vm_id" {
  value = azurerm_linux_virtual_machine.azip_vm.id
}
