# **Azure Application Service Environment v3**

## Overview
**IMPORTANT**
If you want to run this module it is an important requirement to specify the Azure provider version and Terraform version.

This homologated module was aligned to the structure and standards of the **azure-api-management** curated module.

| Terraform version | Azure version |
| :-----: | :-----: |
| 1.8.5 | 3.110.0 |

### Acronym
Acronym for the product is **ase**.

## Description
Application Service Environment v3 (ASEv3) is a fully isolated deployment of Azure App Service into a delegated subnet of a virtual network. This module creates an ASEv3 with standardized tags, provider configuration, optional diagnostic settings and a structure homologated to the API Management curated module.

## Homologation criteria applied
- Standard provider block using `subscriptionid` and `tenantid`
- Standard mandatory tags: `entity`, `environment`, `app_name`, `cost_center`, `tracking_code`
- `custom_tags` and `inherit` behavior homologated to APIM
- `data.azurerm_resource_group` lookup pattern homologated to APIM
- `precondition` validations homologated to APIM
- `diagnostic_settings_enabled`, `diagnostic_settings_name` and `log_analytics_workspace_id` aligned to APIM naming
- Example `backend.tf` and `terraform.tfvars` added, like APIM

## Required variables
### Standard tags
- `entity`
- `environment`
- `app_name`
- `cost_center`
- `tracking_code`

### Deployment scope
- `rsg_name`
- `location`
- `subscriptionid`
- `tenantid`

### ASE
- `ase_name`
- `subnet_id`

## Main optional variables
- `dedicated_host_count`
- `zone_redundant`
- `allow_new_private_endpoint_connections`
- `diagnostic_settings_enabled`
- `diagnostic_settings_name`
- `log_analytics_workspace_id`

## Outputs
- `ase_id`
- `ase_name`
- `ase_dns_suffix`
- `ase_internal_inbound_ip_addresses`

## Usage
```hcl
module "ase" {
  source  = "<ase module source>"
  version = "<ase module version>"

  entity        = var.entity
  environment   = var.environment
  app_name      = var.app_name
  cost_center   = var.cost_center
  tracking_code = var.tracking_code

  rsg_name       = var.rsg_name
  location       = var.location
  subscriptionid = var.subscriptionid
  tenantid       = var.tenantid

  ase_name  = var.ase_name
  subnet_id = var.subnet_id

  diagnostic_settings_enabled = var.diagnostic_settings_enabled
  log_analytics_workspace_id  = var.log_analytics_workspace_id
}
```

## Notes
- The subnet must be delegated to `Microsoft.Web/hostingEnvironments`.
- A `/24` or larger subnet is recommended/required for ASEv3 scenarios.
- If `environment = "pro"`, the module forces diagnostic settings and requires `log_analytics_workspace_id`.
