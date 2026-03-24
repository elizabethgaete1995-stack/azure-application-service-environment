# Resumen de homologación ASE vs APIM

## Objetivo
Dejar el módulo `azure-application-service-environment` lo más parecido posible al módulo `azure-api-management`, especialmente en:
- estructura del módulo
- provider
- tagging estándar
- validaciones
- naming de variables
- patrón de diagnostics

## Cambios aplicados
1. Se eliminó la dependencia del módulo externo de tags y se reemplazó por el mismo patrón inline usado en APIM.
2. Se agregaron variables obligatorias estándar:
   - `entity`
   - `environment`
   - `app_name`
   - `cost_center`
   - `tracking_code`
   - `custom_tags`
   - `inherit`
3. Se agregaron variables obligatorias de despliegue:
   - `rsg_name`
   - `location`
   - `subscriptionid`
   - `tenantid`
4. Se homologó el bloque `terraform` y `provider "azurerm"` al estilo APIM.
5. Se renombró `snt_id` a `subnet_id` para alinear naming con APIM.
6. Se simplificó el patrón de diagnósticos a:
   - `diagnostic_settings_enabled`
   - `diagnostic_settings_name`
   - `log_analytics_workspace_id`
7. Se agregaron `lifecycle.precondition` para validaciones, al igual que APIM.
8. Se agregaron `backend.tf` y `terraform.tfvars` de ejemplo.
9. Se actualizaron outputs y README.

## Diferencias funcionales respecto al ASE original
- Ya no se usa el módulo externo `module-tag`.
- Ya no se mantienen los parámetros legacy de tagging (`product`, `shared_costs`, `apm_functional`, `cia`, `optional_tags`).
- Ya no se incluyen sinks avanzados de diagnostics hacia Event Hub o Storage Account.
- El comportamiento forzado de diagnósticos para producción ahora se basa en `environment = "pro"` en vez de inspeccionar el nombre del resource group.

## Compatibilidad
Este cambio **no es retrocompatible al 100%** con consumidores actuales del módulo ASE original, porque cambia inputs y elimina variables legacy.
