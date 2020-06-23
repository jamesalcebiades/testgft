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
variable "Tags" {
    default     = {
        dev     = "Dev"
        webapi  = "WebAPI"
        kowt    = "KeepOnlineOnlyWorkTime"
    }
}
