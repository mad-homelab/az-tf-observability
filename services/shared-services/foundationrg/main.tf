module "rg_create" {
    source = "../../modules/resource-group"

    service_name = "${var.service_name}"
    deploy_location = "australiasoutheast"
    environment = "${var.environment}"
}