provider "azurerm" {
  subscription_id = var.subscription_id
  #tenant_id = var.tenant_id
  #client_id = var.client_id
  #client_secret = "${var.client_secret}"
  features {
        key_vault {
          purge_soft_delete_on_destroy = true
        }
    }
}

#Resource Group
resource "azurerm_resource_group" "rg" {
  name = "${var.projectname}${var.environment}armrgp001"
  location = var.region
  tags = var.tags
}
#ADF
resource "azurerm_data_factory" "adf" {
  name = "${var.projectname}${var.environment}armadf${var.regioncodename}001"
  location = var.region
  resource_group_name = azurerm_resource_group.rg.name
  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
}
#STA
resource "azurerm_storage_account" "stg-001" {
    #Required
    name = "${var.projectname}${var.environment}armsta${var.regioncodename}001"
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

