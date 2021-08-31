resource "azurerm_resource_group" "rg" {
  name = "${var.projectname}${var.environment}armrgp001"
  location = var.region
  tags = var.tags
}