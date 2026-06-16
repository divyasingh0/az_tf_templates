# ══════════════════════════════════════════════════════════════════════════════
# VARIABLES — inputs exposed to the application layer (Layer 1)
# Only business-level knobs are surfaced here.
# Security defaults, naming, tagging, and monitoring are NOT exposed.
# ══════════════════════════════════════════════════════════════════════════════

variable "app_name" {
  description = "Short application identifier used in naming convention. Lowercase, no hyphens. E.g. edna, storeapp."
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9]+$", var.app_name))
    error_message = "app_name must be lowercase alphanumeric only, no hyphens or underscores."
  }
}

variable "environment" {
  description = "Deployment environment. Allowed values: dev | test | prod."
  type        = string
  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment must be one of: dev, test, prod."
  }
}

variable "location" {
  description = "Azure region for this deployment. E.g. eastus2, uksouth."
  type        = string
}

variable "account_replication_type" {
  description = "Storage replication type. Platform default is GRS. Allowed: LRS, GRS, RAGRS, ZRS, GZRS."
  type        = string
  default     = "GRS"
  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS"], var.account_replication_type)
    error_message = "account_replication_type must be one of: LRS, GRS, RAGRS, ZRS, GZRS."
  }
}

variable "is_hns_enabled" {
  description = "Enable Hierarchical Namespace (required for ADLS Gen2 / Data Lake workloads)."
  type        = bool
  default     = false
}

variable "blob_retention_days" {
  description = "Number of days to retain deleted blobs. Minimum 7, maximum 365."
  type        = number
  default     = 30
  validation {
    condition     = var.blob_retention_days >= 7 && var.blob_retention_days <= 365
    error_message = "blob_retention_days must be between 7 and 365."
  }
}

variable "container_retention_days" {
  description = "Number of days to retain deleted containers. Minimum 7, maximum 365."
  type        = number
  default     = 30
  validation {
    condition     = var.container_retention_days >= 7 && var.container_retention_days <= 365
    error_message = "container_retention_days must be between 7 and 365."
  }
}

variable "notes" {
  description = "Optional free-text note attached to the storage account tag."
  type        = string
  default     = ""
}

variable "workload_tags" {
  description = "Optional additional tags from the application team. Mandatory platform tags always override these."
  type        = map(string)
  default     = {}
}

variable "cors_rules" {
  description = "Optional CORS rules for blob storage. Leave empty for default (no CORS)."
  type = list(object({
    allowed_headers    = optional(list(string))
    allowed_methods    = optional(list(string))
    allowed_origins    = optional(list(string))
    exposed_headers    = optional(list(string))
    max_age_in_seconds = optional(number)
  }))
  default = []
}






/*
variable "storage_account_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "account_tier" {
  type    = string
  default = "Standard"
}

variable "account_replication_type" {
  type    = string
  default = "LRS"
}

variable "min_tls_version" {
  type    = string
  default = "TLS1_2"
}

variable "is_hns_enabled" {
  type    = bool
  default = false
}

variable "blob_retention_days" {
  type    = string
  default = "30"
}

variable "container_retention_days" {
  type    = string
  default = "30"
}

variable "sftp_enabled" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "network_rules" {
  default = null
}

variable "cors_rules" {
  default = []
}
*/