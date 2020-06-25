locals {
    resource_group_name = "${var.resource_group}-${var.env}-${var.countnumber}"
}

# Create resource Group
resource "azurerm_resource_group" "rggft" {
    name = local.resource_group_name
    location = var.region
    tags = var.tags
}