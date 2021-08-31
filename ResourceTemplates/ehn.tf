resource "azurerm_eventhub_namespace" "ehn" {
  name                = "${var.projectname}${var.environment}armehn${var.regioncodename}001"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  capacity            = 1

  tags = var.tags
}

resource "azurerm_eventhub" "evh" {
  name                = "${var.projectname}${var.environment}armevh${var.regioncodename}001"
  namespace_name      = azurerm_eventhub_namespace.rg.name
  resource_group_name = azurerm_resource_group.rg.name
  partition_count     = 2
  message_retention   = 1
}