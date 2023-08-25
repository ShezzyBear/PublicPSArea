# Terraform Coding Challenge
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.70.0"
    }
  }
}

# Provider credentials pull from variables.tf
# Real world application would have file in .gitignore
provider "azurerm" {
  subscription_id = var.subscription.id.labs
  client_id = var.client.id
  client_secret = var.client.secret
  tenant_id = var.tenant.id
  skip_provider_registration = true
  features {
    
  }
}

# Azure Key vault data resource to get key vault resource ID
data "azurerm_key_vault" "example" {
  name                = "connection_string"
  resource_group_name = azurerm_resource_group.example-rg.name
  
  depends_on = [ azurerm_resource_group.example-rg ]
}

# Azure Key vault data resource to get key vault resource secret
data "azurerm_key_vault_secret" "example-kv" {
  name         = "${var.secret.name}"
  key_vault_id = "${data.azurerm_key_vault.keyvault.id}"

  depends_on = [ data.azurerm_key_vault.example ]
}

# Azure Resource Group un-altered. Added depends clause on App_service_plan
resource "azurerm_resource_group" "example-rg" {
  name = "example-rg-${var.environment_abrv}"
  location = data.azurerm_app_service_plan.app_service_plan.location

  depends_on = [ azurerm_app_service_plan ]
}

# Azure Web App had connection string added and value of which is linked 
# to Azure KV.
resource "azurerm_windows_web_app" "example-wa" {
  name = "example-app-${var.environment_abrv}"
  app_service_plan_id = data.azurerm_app_service_plan.app_service_plan.id
  location = data.azurerm_app_service_plan.app_service_plan.location
  resource_group_name = azurerm_resource_group.example-rg.name

  connection_string {
    name = "Context"
    type = "SQLAzure"
    value = data.azurerm_key_vault_secret.example-kv.value
  }

  app_settings = merge(var.app_settings,
  {
    "AppConfigurationName": "${var.app_configuration_instance.name}"
  })

  site_config {
    scm_type = "VSTSRM"
  }

  depends_on = [ azurerm_resource_group.example-rg, azurerm_app_service_plan ]
}