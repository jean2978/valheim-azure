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

resource "azurerm_container_group" "container" {
  location            = var.locaion
  name                = "valheimserver"
  os_type             = "Linux"
  resource_group_name = var.resource_group_name
  ip_address_type = "public"
  dns_name_label = "<something>"
  exposed_port {
    port = 2456
    protocol = "udp"
  }
  exposed_port {
    port = 2457
    protocol = "udp"
  }
  container {
    cpu    = 2
    image  = "lloesche/valheim-server"
    memory = 4
    name   = "valheimserver"
    volume {
      mount_path = "/config"
      name       = "valheim-server-data"
      //storage configuration
      storage_account_key = ""
      storage_account_name = ""
    }
  }
}
