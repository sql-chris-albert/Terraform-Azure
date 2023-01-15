terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "rg-terraform" {
  name     = "rg-terraform"
  location = "East US 2"
}

resource "azurerm_windows_virtual_machine" "vm-terraform" {
  name                = "vm-terraform"
  resource_group_name = azurerm_resource_group.rg-terraform.name
  location            = azurerm_resource_group.rg-terraform.location
  size                = "Standard_B4ms"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.nic-terraform.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftSQLServer"
    offer     = "sql2022-ws2022"
    sku       = "sqldev-gen2"
    version   = "latest"
  }
}