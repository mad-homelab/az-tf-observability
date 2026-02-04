# Storage Account for Terraform remote state
resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.resource_location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  # baseline hardening
  min_tls_version                 = "TLS1_2"
  shared_access_key_enabled = var.shared_access_key_enabled
  allow_nested_items_to_be_public = false

  # public access toggle (to be locked down in Phase 2)
  public_network_access_enabled = var.allow_public_network_access
  tags = {
    environment = var.environment
    service = var.service_name
  }
}

# Private container to hold tfstate blobs
resource "azurerm_storage_container" "this" {
  name                  = var.container_name
  storage_account_id  = azurerm_storage_account.this.id
  container_access_type = "private"
}