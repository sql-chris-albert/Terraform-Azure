resource "azurerm_mssql_server" "sql-server" {
  name                = var.server_name
  resource_group_name = var.resource_group_name
  location            = var.azure_region
  version             = "12.0"

  azuread_administrator {
    login_username              = var.admin_username
    object_id                   = var.admin_object_id
    azuread_authentication_only = true
  }

  tags = {
    environment = var.tag_environment
  }
}

resource "azurerm_mssql_firewall_rule" "example" {
  name             = "AllowAll"
  server_id        = azurerm_mssql_server.sql-server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.55.255.255"
}