resource "azurerm_mssql_database" "sql-db" {
  name      = var.db_name
  server_id = var.server_id
  collation = "SQL_Latin1_General_CP1_CI_AS"
  #license_type         = "BasePrice"
  max_size_gb          = 2
  sku_name             = "Basic"
  storage_account_type = "Local"

  tags = {
    environment = var.tag_environment
  }
}