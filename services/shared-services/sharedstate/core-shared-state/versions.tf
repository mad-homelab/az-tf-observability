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
  features {}
  #Sub ID added as env var
}