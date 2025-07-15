terraform {
  required_version = ">= 1.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "bot_name" {
  type = string
}

variable "msa_app_id" {
  type = string
}

variable "msa_app_password" {
  type      = string
  sensitive = true
}

variable "plan_sku" {
  type    = string
  default = "B1"
}

variable "bot_sku" {
  type    = string
  default = "F0"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "plan" {
  name                = "${var.bot_name}-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Basic"
    size = var.plan_sku
  }
}

resource "azurerm_app_service" "app" {
  name                = "${var.bot_name}-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    application_stack {
      node_version = "~18"
    }
  }
}

resource "azurerm_bot_channel_registration" "bot" {
  name                = var.bot_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.bot_sku

  microsoft_app_id     = var.msa_app_id
  microsoft_app_secret = var.msa_app_password
  messaging_endpoint   = "https://${azurerm_app_service.app.default_site_hostname}/api/messages"
}
