terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.57.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.1.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  use_oidc = true
  use_azuread = true
  storage_use_azuread = true
  features {}
  #Sub ID added as env var
}