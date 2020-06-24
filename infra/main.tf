terraform {
    required_version = ">= 0.11" 
    backend "azurerm" {
        key = "terraform.tfstate"
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