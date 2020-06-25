locals {
    resource_group_name = "${var.resource_group}-${var.env}-${var.countnumber}"
}

# Create resource Group
resource "azurerm_resource_group" "rggft" {
    name = local.resource_group_name
    location = var.region
    tags = var.tags
}

# Create storage account
resource "azurerm_storage_account" "stgft" {
    name    = "storagegft"
    resource_group_name         = local.resource_group_name
    location                    = var.region
    account_tier                = "Standard"
    account_replication_type    = "GRS"
    tags                        = var.tags
}