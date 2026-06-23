# ══════════════════════════════════════════════════════════════════════════════
# OUTPUTS — surfaced back to Layer 1
# ══════════════════════════════════════════════════════════════════════════════
# ══════════════════════════════════════════════════════════════════════════════
# az_terraform_templates/templates/storage-account/output.tf
# OWNERSHIP : Platform Engineering
# ══════════════════════════════════════════════════════════════════════════════

# ══════════════════════════════════════════════════════════════════════════════
# az_terraform_templates/templates/storage-account/output.tf
# OWNERSHIP : Platform Engineering
# ══════════════════════════════════════════════════════════════════════════════

# ── Storage Account outputs ───────────────────────────────────────────────────
output "storage_account_ids" {
  description = "Map of storage account name => Azure Resource ID."
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
  value = module.storage_account.name
}

output "resource_group_name_generated" {
  description = "Resource group name used for this deployment."
  value       = var.resource_group_name
}

# ── VNet + Subnet outputs ─────────────────────────────────────────────────────
# output "vnet_id" {
#   description = "ID of the created Virtual Network."
#   value       = module.vnet[local.vnet_name].id
# }

output "vnets" {
  description = "Virtual networks created by the module"
  value       = module.vnet.vnets
}

# output "pe_subnet_id" {
#   description = "ID of the Private Endpoint subnet."
#   value       = module.vnet.subnets[local.subnet_name].id
# }

# ── Private Endpoint outputs ──────────────────────────────────────────────────
# output "private_endpoint_id" {
#   description = "Resource ID of the private endpoint."
#   value       = azurerm_private_endpoint.blob.id
# }

# output "private_endpoint_name" {
#   description = "Name of the private endpoint."
#   value       = azurerm_private_endpoint.blob.name
# }

# output "private_endpoint_ip" {
#   description = "Private IP address assigned to the storage account blob endpoint. Use this in app config."
#   value       = azurerm_private_endpoint.blob.private_service_connection[0].private_ip_address
# }

# output "private_dns_zone_id" {
#   description = "ID of the Private DNS Zone for blob storage."
#   value       = azurerm_private_dns_zone.blob.id
# }
 