
terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90"
    }
  }
}

# ── 1. NAMING CONVENTION ──────────────────────────────────────────────────────
# All names follow org standard: st<app><env><region_short>001
# App teams never supply resource names directly.

locals {
  region_short = {
    eastus        = "eus"
    eastus2       = "eus2"
    westus        = "wus"
    westus2       = "wus2"
    centralus     = "cus"
    uksouth       = "uks"
    ukwest        = "ukw"
    westeurope    = "weu"
    northeurope   = "neu"
    southeastasia = "sea"
  }

  region_code          = lookup(local.region_short, var.location, var.location)
  storage_account_name = "st${var.app_name}${var.environment}${local.region_code}001"
  resource_group_name  = "rg-${var.app_name}-${var.environment}-${local.region_code}-001"

  # ── Platform-enforced governance tags ──────────────────────────────────────
  # Mandatory tags are composed here. The app team cannot override these.
  # Optional workload tags (var.workload_tags) are merged underneath so
  # mandatory tags always win (mandatory_tags is the right-hand operand).
  composed_tags = merge(
    var.workload_tags,
    {
      managed-by  = "terraform"
      environment = var.environment
      workload    = var.app_name
    }
  )

  # ── Storage account map — exact shape the brownfield module expects ─────────
  # Security defaults are hardcoded here. TLS 1.2, no public access,
  # no cross-tenant replication, SFTP off. App teams cannot weaken these.
  storage_accounts = {
    (local.storage_account_name) = {
      accntname                        = local.storage_account_name
      rgname                           = local.resource_group_name
      location                         = var.location
      account_tier                     = "Standard"
      account_replication_type         = var.account_replication_type
      min_tls_version                  = "TLS1_2"
      allow_nested_items_to_be_public  = false
      is_hns_enabled                   = var.is_hns_enabled
      blob_retention_days              = tostring(var.blob_retention_days)
      container_retention_days         = tostring(var.container_retention_days)
      sftp_enabled                     = false
      cross_tenant_replication_enabled = false
      sa_tags = {
        App   = var.app_name
        Notes = var.notes
      }
      # network_rules left null; network hardening is handled via
      # private endpoints by the platform team separately.
      network_rules = null
      cors_rules    = var.cors_rules
    }
  }
}

module "storage_account" {
  source = "https://github.com/divyasingh0/az_tf_module/tree/abc30744748253ed46ff69e1064f89f9306e7004/storage"
  storage_accounts = local.storage_accounts
}