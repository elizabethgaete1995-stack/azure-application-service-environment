terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.90.0"
    }
  }
}

provider "azurerm" {
  subscription_id            = var.subscriptionid
  tenant_id                  = var.tenantid
  skip_provider_registration = true

  features {}
}

#########################
# Locals (estandarizados)
#########################
locals {
  private_tags = {
    "hidden-deploy" = "curated"
  }

  standard_tags = {
    entity        = var.entity
    environment   = lower(var.environment)
    app_name      = var.app_name
    cost_center   = var.cost_center
    tracking_code = var.tracking_code
  }

  tags           = merge(local.standard_tags, local.private_tags, var.custom_tags)
  tags_inherited = merge(data.azurerm_resource_group.rsg_principal.tags, local.private_tags, local.standard_tags, var.custom_tags)

  effective_tags = var.inherit ? local.tags_inherited : local.tags

  diagnostic_settings_effective = lower(var.environment) == "pro" ? true : var.diagnostic_settings_enabled
}

data "azurerm_resource_group" "rsg_principal" {
  name = var.rsg_name
}

#########################
# ASEv3
#########################
resource "azurerm_app_service_environment_v3" "ase" {
  name                                   = var.ase_name
  resource_group_name                    = data.azurerm_resource_group.rsg_principal.name
  subnet_id                              = var.subnet_id
  internal_load_balancing_mode           = var.internal_load_balancing_mode
  dedicated_host_count                   = var.dedicated_host_count
  zone_redundant                         = var.dedicated_host_count != null ? null : var.zone_redundant
  allow_new_private_endpoint_connections = var.allow_new_private_endpoint_connections
  tags                                   = local.effective_tags

  cluster_setting {
    name  = "InternalEncryption"
    value = tostring(var.internal_encryption_enabled)
  }

  cluster_setting {
    name  = "DisableTls1.0"
    value = var.disable_tls_1_0 ? "1" : "0"
  }

  lifecycle {
    precondition {
      condition     = !(trim(coalesce(var.subnet_id, "")) == "")
      error_message = "Debes entregar subnet_id para desplegar el ASEv3."
    }

    precondition {
      condition     = !(var.dedicated_host_count != null && var.zone_redundant)
      error_message = "No puedes usar dedicated_host_count y zone_redundant al mismo tiempo."
    }

    precondition {
      condition     = !(local.diagnostic_settings_effective && (trim(coalesce(var.log_analytics_workspace_id, "")) == ""))
      error_message = "Si diagnostic_settings_enabled=true o environment=pro, debes entregar log_analytics_workspace_id."
    }
  }
}

#########################
# Diagnostic settings (opcional)
#########################
resource "azurerm_monitor_diagnostic_setting" "ase_diag" {
  count = local.diagnostic_settings_effective ? 1 : 0

  name                       = var.diagnostic_settings_name
  target_resource_id         = azurerm_app_service_environment_v3.ase.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "AppServiceEnvironmentPlatformLogs"
  }

  metric {
    category = "AllMetrics"
  }
}
