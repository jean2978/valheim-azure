terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "storage" {
  account_replication_type = "LRS"
  account_tier = "Premium"
  account_kind = "FileStorage"
  location                 = var.location
  name                     = "${var.project_name}-storage"
  resource_group_name      = var.resource_group_name
}