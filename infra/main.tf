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

# Create API Management
resource "azurerm_api_management" "api_management" {
    name        = "apim-dev-001"
    location    = var.region
    resource_group_name = azurerm_resource_group.rg_gft.name
    publisher_name      = "GFT"
    publisher_email     = "teste@gft.com"
    sku_name            = "dev_api"

    policy {
        xml_content = <<XML
            <policies>
            <inbound />
            <backend />
            <outbound />
            <on-error />
            </policies>
        XML

    }
}

# # Create AKS
# resource "azurerm_kubernetes_clusters" "aks_gft" {
#     name                = var.cluster_name
#     location            = var.region
#     resource_group_name = azurerm_resource_group.rg_gft.name
#     dns_prefix          = var.dns_name
#     kubernetes_version  = var.kubernetes_version

#     dynamic "agent_pool_profile" {
#     for_each = var.agent_pools
#     iterator = pool
#     content {
#       name            = pool.value.name
#       count           = pool.value.count
#       vm_size         = pool.value.vm_size
#       os_type         = pool.value.os_type
#       os_disk_size_gb = pool.value.os_disk_size_gb
#       type            = "VirtualMachineScaleSets"
#       max_pods        = 100
#       vnet_subnet_id  = azurerm_subnet.aks_subnet.id
#     }
#   }

#   linux_profile {
#     admin_username = var.admin_username
#     ssh_key {
#       key_data = data.azurerm_key_vault_secret.ssh_public_key.value
#     }
#   }

#   network_profile {
#     network_plugin     = "azure"
#     network_policy     = "azure"     # Options are calico or azure - only if network plugin is set to azure
#     dns_service_ip     = "172.16.0.10" # Required when network plugin is set to azure, must be in the range of service_cidr and above 1
#     docker_bridge_cidr = "172.17.0.1/16"
#     service_cidr       = "172.16.0.0/16" # Must not overlap any address from the VNEt
#   }

#    role_based_access_control {
#     enabled = true
#   }

#   service_principal {
#     client_id     = data.azurerm_key_vault_secret.spn_id.value
#     client_secret = data.azurerm_key_vault_secret.spn_secret.value
#   }

#   tags = var.tags
 
# }

# output "client_certificate" {
#   value = "${azurerm_kubernetes_cluster.aks_k2.kube_config.0.client_certificate}"
# }

# output "kube_config" {
#   value = "${azurerm_kubernetes_cluster.aks_k2.kube_config_raw}"
# }

terraform {
    required_version = ">= 0.11" 
    backend "azurerm" {
              
    }
}

# Configure the Azure Provider
provider "azurerm" {
   version = "~> 1.32"
}




