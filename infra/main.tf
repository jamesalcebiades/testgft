provider "azurerm" {
  version = "~> 2.15"
  features{}
}

locals {
    # Name resource group
    resource_group_name     = "${var.resource_group}-${var.env}-${var.countnumber}"

    # Name API Management
    name_api                = "${var.apim}-${var.env}-${var.countnumber}"

    # Name AKS
    name_aks                = "${var.aks}-${var.env}-${var.countnumber}"

    apim_vnet_type          = var.apim_virtual_network_type

    apim_vnet_enabled       = local.apim_vnet_type != "None"

    apim_identity_enabled   = var.apim_identity_type != ""
}

resource "null_resource" "module_depends_on" {
  triggers = {
    value = "${length(var.module_depends_on)}"
  }
}

module "naming" {
  source = "git::https://github.com/Azure/terraform-azurerm-naming"
  suffix = var.suffix
  prefix = var.prefix
}

# Create resource Group
resource "azurerm_resource_group" "rggft" {
    name = local.resource_group_name
    location = var.region
    tags = var.tags
}

# Create API Management
resource "azurerm_api_management" "apigft" {
    name                = local.name_api
    location            = var.region
    resource_group_name = local.resource_group_name
    publisher_name      = "GFT"
    publisher_email     = "test@gft.com"

    sku_name            = "Developer_1"

    tags                = var.tags

    virtual_network_type    = local.apim_vnet_type

    dynamic "virtual_network_configuration" {
        for_each = local.apim_vnet_enabled ? [1] : []

        content {
            subnet_id = data.azurerm_subnet.subnet[0].id
    }
  }

  dynamic "certificate" {
    for_each = var.certificates

    content {
      encoded_certificate  = certificate.value.b64_encoded_certificate
      certificate_password = certificate.value.certificate_password
      store_name           = certificate.value.store_name
    }
  }

  dynamic "identity" {
    for_each = local.apim_identity_enabled ? [1] : []

    content {
      type         = var.apim_identity_type
      identity_ids = length(var.apim_identity_ids) > 0 ? var.apim_identity_ids : null
    }
  }

  policy {
    xml_content = file(var.apim_policies_path)
  }

  depends_on = [null_resource.module_depends_on]

}

resource "azurerm_key_vault_access_policy" "apim" {
  key_vault_id = data.azurerm_key_vault.keyvault[0].id

  tenant_id = azurerm_api_management.apigft.identity[0].tenant_id
  object_id = azurerm_api_management.apigft.identity[0].principal_id

  secret_permissions = [
    "get",
  ]

  count = var.apim_key_vault_enabled ? 1 : 0
}

resource "null_resource" "apim" {
  depends_on = [
    azurerm_key_vault_access_policy.apim,
    azurerm_api_management.apim
  ]

  triggers = {
    apim_name                         = azurerm_api_management.apigft.name
    apim_rg_name                      = azurerm_api_management.apigft.resource_group_name
    apim_mgmt_host                    = var.apim_management_host_name
    apim_mgmt_kv_id                   = var.apim_management_key_vault_id
    apim_mgmt_client_cert             = var.apim_management_negotiate_client_certificate
    apim_portal_host                  = var.apim_portal_host_name
    apim_portal_kv_id                 = var.apim_portal_key_vault_id
    apim_portal_client_cert           = var.apim_portal_negotiate_client_certificate
    apim_developer_portal_host        = var.apim_developer_portal_host_name
    apim_developer_portal_kv_id       = var.apim_developer_portal_key_vault_id
    apim_developer_portal_client_cert = var.apim_developer_portal_negotiate_client_certificate
    apim_scm_host                     = var.apim_scm_host_name
    apim_scm_kv_id                    = var.apim_scm_key_vault_id
    apim_scm_client_cert              = var.apim_scm_negotiate_client_certificate
  }

  provisioner "local-exec" {
    command = format("%s/scripts/host_config.sh %s %s %s %s %s %s %s %s %s %s %s %s %s %s",
      path.module,
      azurerm_api_management.apigft.name,
      azurerm_api_management.apigft.resource_group_name,
      var.apim_management_host_name,
      var.apim_management_key_vault_id,
      var.apim_management_negotiate_client_certificate,
      var.apim_portal_host_name,
      var.apim_portal_key_vault_id,
      var.apim_portal_negotiate_client_certificate,
      var.apim_developer_portal_host_name,
      var.apim_developer_portal_key_vault_id,
      var.apim_developer_portal_negotiate_client_certificate,
      var.apim_scm_host_name,
      var.apim_scm_key_vault_id,
      var.apim_scm_negotiate_client_certificate
    )
  }

  count = var.apim_key_vault_enabled ? 1 : 0
}

resource "azurerm_api_management_authorization_server" "apim" {
  name                         = var.apim_authorization_server_name
  api_management_name          = azurerm_api_management.apigft.name
  authorization_methods        = var.apim_authorization_server_methods
  resource_group_name          = local.resource_group_name
  display_name                 = var.apim_authorization_server_display_name
  authorization_endpoint       = var.apim_authorization_server_auth_endpoint
  token_endpoint               = var.apim_authorization_server_token_endpoint
  bearer_token_sending_methods = var.apim_bearer_token_sending_methods
  client_id                    = var.apim_authorization_server_client_id
  client_registration_endpoint = var.apim_authorization_server_registration_endpoint

  grant_types = var.apim_authorization_server_grant_types

  count = var.enable_authorization_server ? 1 : 0
}

# Create AKS
# resource "azurerm_kubernetes_cluster" "aksgft" {
#     name                = local.name_aks
#     location            = var.region
#     resource_group_name = local.resource_group_name
#     dns_prefix          = "gftdns"

#     default_node_pool {
#         name            = "default"
#         node_count      = 1
#         vm_size         = "Standard_D2_v2"
#     }

#     identity {
#         type = "SystemAssigned"
#     }
    
#     tags = var.tags
# }
# output "client_certificate" {
#   value = azurerm_kubernetes_cluster.aksgft.kube_config.0.client_certificate
# }

# output "kube_config" {
#   value = azurerm_kubernetes_cluster.aksgft.kube_config_raw
# }