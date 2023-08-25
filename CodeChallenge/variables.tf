# Terraform Coding Challenge
variable "environment_abrv:" {
  type = string
  default = "Dev"
}

variable "app_configuration_instance" {
  type = object({
    name = string
    default = "Something"
    resource_group: string
  })
}

variable "app_settings" {
  type = map(string)
  default = {
    "name" = "value"
  }
}

variable "secret.name" {
  type = string
  default = "connection_string"
}

variable "tenant.id" {
  description = "Azure Tenant ID information for Example.com"
  type = string
  default = "444-444-44444-4444"
}

variable "subscription.id.dev" {
  description = "Azure Subscription ID information for Example Dev Subscription"
  type = string
  default = "444-444-44444-4444"
}

variable "subscription.id.uat" {
  description = "Azure Subscription ID information for Example UAT Subscription"
  type = string
  default = "444-444-44444-4444"
}

variable "subscription.id.prod" {
  description = "Azure Subscription ID information for Example Production Subscription"
  type = string
  default = "444-444-44444-4444"
}

variable "client.id" {
  description = "Azure Client ID information for Example"
  type = string
  default = "444-444-44444-4444"
}

variable "client.secret" {
  description = "Azure Client Secret information for Example"
  type = string
  default = "444-444-44444-4444"
}