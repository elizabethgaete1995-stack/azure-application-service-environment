#####################################
# Tags estándar (obligatorios)
#####################################
entity        = "ClaroChile"
environment   = "dev"          # dev | pre | pro
app_name      = "esim-ase"
cost_center   = "CC-IT-001"
tracking_code = "PRJ-ESIM-2026"

#####################################
# Resource Group / Ubicación
#####################################
rsg_name       = "rg-poc-test-001"
location       = "chilecentral"
subscriptionid = "00000000-0000-0000-0000-000000000000"
tenantid       = "00000000-0000-0000-0000-000000000000"

#####################################
# Azure App Service Environment v3
#####################################
ase_name   = "cl-ase-dev-esim-01"
subnet_id  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-network-dev/providers/Microsoft.Network/virtualNetworks/vnet-dev/subnets/snet-ase"

# Opcionales
# dedicated_host_count                   = 2
# zone_redundant                         = false
# allow_new_private_endpoint_connections = false
# diagnostic_settings_enabled            = false
# diagnostic_settings_name               = "ase-diagnostics"
# log_analytics_workspace_id             = "/subscriptions/.../resourceGroups/.../providers/Microsoft.OperationalInsights/workspaces/..."
