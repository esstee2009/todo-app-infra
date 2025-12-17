terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.54.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "tf-rg24"
    storage_account_name = "tfstorage24"
    container_name = "cloudcore"
    key = "4each.tfstate"
  }
}

provider "azurerm" {
  features {}
subscription_id = "bc524287-f28f-43cf-9bc7-37559e1c0887"
}