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

resource "azurerm_resource_group" "rg-terraform" {
  name     = "rg-terraform"
  location = "East US 2"
}

resource "azurerm_mssql_server" "sql-server-terraform" {
  name                = "sql-server-terraform"
  resource_group_name = azurerm_resource_group.rg-terraform.name
  location            = azurerm_resource_group.rg-terraform.location
  version             = "12.0"

  azuread_administrator {
    login_username              = "db_admin"
    object_id                   = "85814e6d-b552-4738-9414-2a20f60e7313"
    azuread_authentication_only = true
  }

  tags = {
    environment = "development"
  }
}

resource "azurerm_mssql_database" "db-terraform" {
  name                 = "db-terraform"
  server_id            = azurerm_mssql_server.sql-server-terraform.id
  collation            = "SQL_Latin1_General_CP1_CI_AS"
  license_type         = "LicenseIncluded"
  max_size_gb          = 2
  sku_name             = "Basic"
  storage_account_type = "Local"

  tags = {
    foo = "bar"
  }
}
