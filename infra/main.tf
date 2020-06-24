terraform {
    required_version = ">= 0.11" 
    backend "azurerm" {
        storage_account_name    = "storagegft"
        container_name          = "terraform"
        key                     = "terraform.tfstate"
        acess_key               = "__storagekey__"
        features{}
    }
}
# Configure the Azure Provider
provider "azurerm" {
   version = "~> 1.32"
}
# Create resource group
resource "azurerm_resource_group" "rg_gft" {
    name        = "rs-gp-dev-001"
    location    = var.region
    tags        = var.tags
}

# Create storage account
resource "azurerm_storage_account" "stg" {
    name    = "storagegft"
    resource_group_name         = azurerm_resource_group.rg_gft.name
    location                    = var.region
    account_tier                = "Standard"
    account_replication_type    = "GRS"
    tags                        = var.tags
}

