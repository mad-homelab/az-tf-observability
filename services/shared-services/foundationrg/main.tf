module "rg_create" {
    source = "../../modules/resource-group"

    service_name = "${var.service_name}"
    location = "australiasoutheast"
    environment = "${var.environment}"
}