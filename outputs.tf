output "ase_id" {
  description = "ID del App Service Environment."
  value       = azurerm_app_service_environment_v3.ase.id
}

output "ase_name" {
  description = "Nombre del App Service Environment."
  value       = azurerm_app_service_environment_v3.ase.name
}

output "ase_dns_suffix" {
  description = "DNS suffix del ASEv3."
  value       = azurerm_app_service_environment_v3.ase.dns_suffix
}

output "ase_internal_inbound_ip_addresses" {
  description = "IPs internas de entrada del ASE, si aplica."
  value       = azurerm_app_service_environment_v3.ase.internal_inbound_ip_addresses
}
