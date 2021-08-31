resource "azurerm_storage_account" "stg" {
  name                     = "${var.projectname}${var.environment}armdls${var.regioncodename}001"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = var.accounttier
  account_replication_type = var.replication
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "fs" {
  name               = var.fsname
  storage_account_id = azurerm_storage_account.stg.id

}