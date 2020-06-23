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
    name        = "${var.resource_group}""${var.env}""-${var.countnumber}"
    location    = var.region
    tags        = var.tags
}