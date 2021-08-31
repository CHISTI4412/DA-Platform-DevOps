#ADB
resource "azurerm_databricks_workspace" "adb" {
  name = "${var.projectname}${var.environment}armadb${var.regioncodename}001"
  location = var.region
  resource_group_name = azurerm_resource_group.rg.name
  sku = var.adbsku
  tags = var.tags
}
terraform {
  required_providers {
    databricks = {
      source = "databrickslabs/databricks"
      version = "0.2.9"
    }
  }
}
provider "databricks" {
  azure_workspace_resource_id = azurerm_databricks_workspace.adb.id
}
data "databricks_node_type" "smallest" {
  local_disk = true
}
data "databricks_group" "admins" {
    display_name = "admins"
}
resource "databricks_cluster" "clr" {
  cluster_name = "cls-${var.projectname}-01"
  spark_version = "7.4.x-scala2.12"
  node_type_id = data.databricks_node_type.smallest.id
  autotermination_minutes = var.autoshutdownmins
  num_workers = 1
  spark_conf = {
    "spark.databricks.passthrough.enabled": true
  }
  single_user_name = var.adminuser
  depends_on = [azurerm_databricks_workspace.adb]
}