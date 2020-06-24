# Variables basead
variable "env" {
    type    = string
    default = "dev"
}
variable "countnumber" {
    type    = string
    default = "001"
}

#  Resource Group Name
variable "resource_group" {
  type    = string
  default = "rs-gp-"
}

# Azure region default
variable "region" {
  type    = string
  default = "eastus"
}

# Variable name API
variable "apim" {
    type    = string
    default = "apim"
}

# Variable name AKS
variable "aks" {
    type    = string
    default = "aks"
}

# Variables Tag
variable "tags" {
    default     = {
        dev     = "Dev"
        webapi  = "WebAPI"
        kowt    = "KeepOnlineOnlyWorkTime"
    }
}

# AKS Cluster name
variable "cluster_name" {
  type    = string
  default = "aks"
}

#AKS DNS name
variable "dns_name" {
  type    = string
  default = "dnsgft"
}

# Specify a valid kubernetes version
variable "kubernetes_version" {
  type    = string
  default = "1.14.3"
}

#AKS Agent pools
variable "agent_pools" {
  default = [
    {
      name            = "pool1"
      count           = 3
      vm_size         = "Standard_D1_v2"
      os_type         = "Linux"
      os_disk_size_gb = "30"
    }
  ]
}

# admin user
variable "admin_username" {
  type    = string
  default = "aksadmin"
}

# Source´s

# data "azurerm_key_vault" "terraform_vault" {
#   name                = var.keyvault_name
#   resource_group_name = var.keyvault_rg
# }

# data "azurerm_key_vault_secret" "ssh_public_key" {
#   name         = "LinuxSSHPubKey"
#   key_vault_id = data.azurerm_key_vault.terraform_vault.id
# }

# data "azurerm_key_vault_secret" "spn_id" {
#   name         = "spn-id"
#   key_vault_id = data.azurerm_key_vault.terraform_vault.id
# }
# data "azurerm_key_vault_secret" "spn_secret" {
#   name         = "spn-secret"
#   key_vault_id = data.azurerm_key_vault.terraform_vault.id
# }