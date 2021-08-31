resource "azurerm_storage_account" "stg" {
    #Required
    name = "${var.projectname}${var.environment}armdls${var.regioncodename}001"
    location = var.region
    resource_group_name = azurerm_resource_group.rg.name
    account_tier = var.accounttier
    account_replication_type = var.replication
    #Optional
    access_tier = var.accesstier
    enable_https_traffic_only = true
    allow_blob_public_access = false
    is_hns_enabled = true
    identity {
      type = "SystemAssigned"
    }
}