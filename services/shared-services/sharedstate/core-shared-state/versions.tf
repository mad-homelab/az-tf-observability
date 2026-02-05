terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.57.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  use_oidc = true
  storage_use_azuread = true
  features {}
  #Sub ID added as env var
}