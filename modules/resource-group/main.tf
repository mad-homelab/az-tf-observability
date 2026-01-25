resource "azurerm_resource_group" "rg" {
  name     = "${var.service_name}-rg-${var.environment}"
  location = "${var.deploy_location}"
  tags = {
    environment = "${var.environment}"
    service = "${var.service_name}"
  }
}