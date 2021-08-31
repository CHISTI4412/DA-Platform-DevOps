resource "azurerm_key_vault" "akv" {
  name = "${var.projectname}${var.environment}armkey${var.regioncodename}001"
  location = var.region
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = var.retention
  sku_name = var.akvsku
  enable_rbac_authorization = var.rbacenabled
}