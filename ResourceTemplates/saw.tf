#DLS for Synapse
resource "azurerm_storage_account" "stg" {
  name                     = "${var.projectname}${var.environment}armdls${var.regioncodename}001"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = var.sawaccounttier
  account_replication_type = var.sawreplication
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "fs" {
  name               = var.fsname
  storage_account_id = azurerm_storage_account.stg.id
}

#SAW
resource "azurerm_synapse_workspace" "syn" {
  name                                 = "${var.projectname}${var.environment}armsaw${var.regioncodename}001"
  resource_group_name                  = azurerm_resource_group.rg.name
  location                             = azurerm_resource_group.rg.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.fs.id
  sql_administrator_login              = var.sqladminlogin
  sql_administrator_login_password     = var.sqladminpass
}

resource "azurerm_synapse_spark_pool" "syn-sp" {
  name                 = "${var.projectname}${var.environment}armapa${var.regioncodename}001"
  synapse_workspace_id = azurerm_synapse_workspace.syn.id
  node_size_family     = var.nodesizefamily
  node_size            = var.nodesize

  auto_scale {
    max_node_count = var.maxnodecount
    min_node_count = var.minnodecount
  }
  auto_pause {
    delay_in_minutes = 15
  }
  tags = var.tags
}

resource "azurerm_synapse_sql_pool" "syn-sqlp" {
  name = "${var.projectname}${var.environment}armadw${var.regioncodename}001"
  synapse_workspace_id = azurerm_synapse_workspace.syn.id
  sku_name = "DW100c"
    tags = var.tags
}