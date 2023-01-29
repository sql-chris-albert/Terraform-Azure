terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.4.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-storage-accounts" {
  name     = "rg-storage-accounts"
  location = "East US 2"
}

resource "azurerm_storage_account" "storage-acct-terraform" {
  name                     = "storageaccttf"
  resource_group_name      = azurerm_resource_group.rg-storage-accounts.name
  location                 = azurerm_resource_group.rg-storage-accounts.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "backups" {
  name                  = "backups"
  storage_account_name  = azurerm_storage_account.storage-acct-terraform.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "example" {
  name                   = "AdventureWorks2019.bak"
  storage_account_name   = azurerm_storage_account.storage-acct-terraform.name
  storage_container_name = azurerm_storage_container.backups.name
  type                   = "Block"
  source                 = "C:\\Test\\AdventureWorks2019.bak"
}