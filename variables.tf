############################
# Tags estándar (obligatorio)
############################
variable "entity" {
  description = "Nombre del cliente."
  type        = string
}

variable "environment" {
  description = "Ambiente: dev, pre, pro."
  type        = string
  validation {
    condition     = contains(["dev", "pre", "pro"], lower(var.environment))
    error_message = "environment debe ser: dev, pre o pro."
  }
}

variable "app_name" {
  description = "Nombre de la aplicación."
  type        = string
}

variable "cost_center" {
  description = "Identificador del centro de costo."
  type        = string
}

variable "tracking_code" {
  description = "Nombre/código del proyecto."
  type        = string
}

variable "custom_tags" {
  description = "Tags adicionales."
  type        = map(string)
  default     = {}
}

variable "inherit" {
  description = "Si true, hereda tags del Resource Group y los mezcla con standard + custom."
  type        = bool
  default     = true
}

############################################
# Resource Group / Location / Subscription
############################################
variable "rsg_name" {
  description = "Nombre del Resource Group donde se despliega."
  type        = string
}

variable "location" {
  description = "Azure region donde se despliega (ej: eastus2, brazilsouth)."
  type        = string
}

variable "subscriptionid" {
  description = "Subscription ID destino."
  type        = string
}

variable "tenantid" {
  description = "Tenant ID destino."
  type        = string
}

############################
# Básicos ASE (obligatorios)
############################
variable "ase_name" {
  description = "Nombre del App Service Environment v3."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID para el ASEv3. La subnet debe estar delegada a Microsoft.Web/hostingEnvironments y ser /24 o mayor."
  type        = string
}

############################
# Configuración ASE (opcional)
############################
variable "internal_load_balancing_mode" {
  description = "Modo ILB del ASE. Valores válidos habituales: Web, Publishing o Web, Publishing."
  type        = string
  default     = "Web, Publishing"
}

variable "dedicated_host_count" {
  description = "Cantidad de dedicated hosts. Si se define, no debe usarse zone_redundant."
  type        = number
  default     = 2
}

variable "zone_redundant" {
  description = "Habilita zone redundancy. Solo aplica cuando dedicated_host_count es null."
  type        = bool
  default     = false
}

variable "allow_new_private_endpoint_connections" {
  description = "Permite nuevas conexiones de Private Endpoint al ASE."
  type        = bool
  default     = false
}

variable "internal_encryption_enabled" {
  description = "Habilita el cluster setting InternalEncryption."
  type        = bool
  default     = true
}

variable "disable_tls_1_0" {
  description = "Deshabilita TLS 1.0 en el ASE mediante cluster setting."
  type        = bool
  default     = true
}

############################
# Diagnósticos a Log Analytics (opcional)
############################
variable "diagnostic_settings_enabled" {
  description = "Habilita Diagnostic Settings hacia Log Analytics. En pro se fuerza a true."
  type        = bool
  default     = false
}

variable "diagnostic_settings_name" {
  description = "Nombre de la configuración de diagnóstico."
  type        = string
  default     = "ase-diagnostics"
}

variable "log_analytics_workspace_id" {
  description = "ID del Log Analytics Workspace. Requerido si diagnostic_settings_enabled=true o environment=pro."
  type        = string
  default     = null
}
