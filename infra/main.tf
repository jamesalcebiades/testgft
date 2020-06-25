provider "azurerm" {
  version = "~> 2.15"
  features{}
}

locals {
    # Name resource group
    resource_group_name = "${var.resource_group}-${var.env}-${var.countnumber}"

    # Name API Management
    name_api            = "${var.apim}-${var.env}-${var.countnumber}"

    # Name AKS
    name_aks            = "${var.aks}-${var.env}-${var.countnumber}"
}

# # Create resource Group
# resource "azurerm_resource_group" "rggft" {
#     name = local.resource_group_name
#     location = var.region
#     tags = var.tags
# }

# Create API Management
# resource "azurerm_api_management" "apigft" {
#     name                = local.name_api
#     location            = var.region
#     resource_group_name = local.resource_group_name
#     publisher_name      = "GFT"
#     publisher_email     = "test@gft.com"

#     sku_name            = "Developer_1"

#     tags                = var.tags
# }

# Create AKS
resource "azurerm_kubernetes_cluster" "aksgft" {
    name                = local.name_aks
    location            = var.region
    resource_group_name = local.resource_group_name
    dns_prefix          = "gftdns"

    default_node_pool {
        name            = "default"
        node_count      = 2
        min_count       = 2
        max_count       = 3
        vm_size         = "Standard_D2_v2"
    }

    identity {
        type = "SystemAssigned"
    }
    
    tags = var.tags
}
output "client_certificate" {
  value = azurerm_kubernetes_cluster.aksgft.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aksgft.kube_config_raw
}