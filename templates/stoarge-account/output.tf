# ══════════════════════════════════════════════════════════════════════════════
# OUTPUTS — surfaced back to Layer 1
# ══════════════════════════════════════════════════════════════════════════════

output "storage_account_ids" {
  description = "Map of storage account name => resource ID."
  value       = module.storage_account.id
}

output "storage_account_names" {
  description = "Map of storage account name => name."
  value       = module.storage_account.name
}

output "storage_account_primary_blob_endpoints" {
  description = "Map of storage account name => primary blob endpoint URL."
  value       = module.storage_account.primary_blob_endpoint
}

output "storage_account_name_generated" {
  description = "The auto-generated storage account name (for reference by pipeline or app team)."
  value       = local.storage_account_name
}

output "resource_group_name_generated" {
  description = "The auto-generated resource group name (for reference by pipeline or app team)."
  value       = local.resource_group_name
}




