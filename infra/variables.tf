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
  default = "rs-gp"
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

# admin password
variable "admin_username" {
    type    = string
    default = "azureuser"
}

# Virtual network
variable "apim_virtual_network_type" {
  type        = string
  default     = "None"
}

variable "apim_policies_path" {
  type        = string
  description = "Path to a file defining the Azure API Management policies in XML"
  default     = ""
}

variable "module_depends_on" {
  default = [""]
}

variable "certificates" {
  type = set(object({
    b64_encoded_certificate = string
    certificate_password    = string
    store_name              = string
  }))
  description = "Client certificates for backend mTLS"
  default     = []
}
variable "apim_identity_ids" {
  type        = set(string)
  description = "Set of IDs for User Assigned Managed Identity resources to be assigned"
  default     = []
}
variable "apim_management_host_name" {
  type        = string
  description = "The Hostname to use for the Management API"
  default     = ""
}

variable "apim_management_key_vault_id" {
  type        = string
  description = "The ID of the Azure Key Vault secret containing the certificate"
  default     = "-"
}

variable "apim_management_negotiate_client_certificate" {
  type        = bool
  description = "Should Client Certificate Negotiation be enabled for this Hostname?"
  default     = false
}

variable "apim_portal_host_name" {
  type        = string
  description = "The Hostname to use for the portal API"
  default     = ""
}

variable "apim_portal_key_vault_id" {
  type        = string
  description = "The ID of the Azure Key Vault secret containing the certificate"
  default     = "-"
}

variable "apim_portal_negotiate_client_certificate" {
  type        = bool
  description = "Should Client Certificate Negotiation be enabled for this Hostname?"
  default     = false
}

variable "apim_developer_portal_host_name" {
  type        = string
  description = "The Hostname to use for the developer portal API"
  default     = ""
}

variable "apim_developer_portal_key_vault_id" {
  type        = string
  description = "The ID of the Azure Key Vault secret containing the certificate"
  default     = "-"
}

variable "apim_developer_portal_negotiate_client_certificate" {
  type        = bool
  description = "Should Client Certificate Negotiation be enabled for this Hostname?"
  default     = false
}

variable "apim_scm_host_name" {
  type        = string
  description = "The Hostname to use for the scm portal API"
  default     = ""
}

variable "apim_scm_key_vault_id" {
  type        = string
  description = "The ID of the Azure Key Vault secret containing the certificate"
  default     = "-"
}

variable "apim_scm_negotiate_client_certificate" {
  type        = bool
  description = "Should Client Certificate Negotiation be enabled for this Hostname?"
  default     = false
}

variable "apim_authorization_server_name" {
  type        = string
  description = "The name of the Authorization Server"
  default     = ""
}

variable "apim_bearer_token_sending_methods" {
  type        = set(string)
  description = "The mechanism by which Access Tokens are passed to the API"
  default     = ["authorizationHeader"]
}

variable "apim_authorization_server_client_id" {
  type        = string
  description = "A Authorization Server client id"
  default     = ""
}

variable "apim_authorization_server_registration_endpoint" {
  type        = string
  description = "The Authorization Server registration endpoint"
  default     = ""
}

variable "apim_authorization_server_grant_types" {
  type        = set(string)
  description = "Grant types to use with the Authorization Server"
  default     = ["authorizationCode"]
}

# Variables Tag
variable "tags" {
    default     = {
        dev     = "Dev"
        webapi  = "WebAPI"
        kowt    = "KeepOnlineOnlyWorkTime"
    }
}
