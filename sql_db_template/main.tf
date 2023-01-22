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

resource "azurerm_resource_group" "rg-terraform-01" {
  name     = "rg-terraform-use2"
  location = "East US 2"
}

resource "azurerm_resource_group" "rg-terraform-02" {
  name     = "rg-terraform-usw2"
  location = "West US 2"
}

module "sql-server-01" {
  source = "./modules/azure_sql_server"

  server_name         = "sql-server-use2"
  resource_group_name = azurerm_resource_group.rg-terraform-01.name
  azure_region        = azurerm_resource_group.rg-terraform-01.location
  admin_username      = "db_admin"
  admin_object_id     = "85814e6d-b552-4738-9414-2a20f60e7313"
  tag_environment     = "development"
}

module "sql-server-02" {
  source = "./modules/azure_sql_server"

  server_name         = "sql-server-usw2"
  resource_group_name = azurerm_resource_group.rg-terraform-02.name
  azure_region        = azurerm_resource_group.rg-terraform-02.location
  admin_username      = "db_admin"
  admin_object_id     = "85814e6d-b552-4738-9414-2a20f60e7313"
  tag_environment     = "development"
}

module "sql-db-01" {
  source = "./modules/azure_sql_db"

  db_name         = "sql-db-01"
  server_id       = module.sql-server-01.id
  tag_environment = "development"
}

module "sql-db-02" {
  source = "./modules/azure_sql_db"

  db_name         = "sql-db-02"
  server_id       = module.sql-server-02.id
  tag_environment = "development"
}