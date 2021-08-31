resource "azurerm_data_factory" "adf" {
  name = "${var.projectname}${var.environment}armadf${var.regioncodename}001"
  location = var.region
  resource_group_name = azurerm_resource_group.rg.name
  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
}