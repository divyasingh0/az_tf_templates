# terraform {
#   required_version = ">= 1.3.0"

#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "~> 3.90"
#     }
#   }
# }

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

module "vnet" {
  source = "git::https://github.com/divyasingh0/az_tf_module.git//demo_folder/virtual_network?ref=e2eab019bf884c922b50fd17dfc5e7c5f3f3adf0"


  vnets = {
    primary = {
      vnet_rgname        = var.resource_group_name
      vnet_location      = var.location
      vnet_address_space = [var.vnet_address_space]
      dns_servers        = var.dns_servers

      resource_name_config = {
        resource_type = "vnet"
        application   = var.app_name
        environment   = var.environment
        region        = var.location
        cloud         = "az"
        instance      = "01"
        use_hyphen    = true
      }

      mandatory_tags = var.mandatory_tags
      optional_tags  = var.optional_tags
      custom_tags    = var.custom_tags
      resource_specific_tags = {}
    }
  }
subnets = {
  pe = {
    subnet_name                                   = "snet-pe"
    subnet_address_prefixes                       = [var.pe_subnet_prefix]
    subnet_rgname                                 = var.resource_group_name
    vnet_key                                      = "primary"
    private_endpoint_network_policies             = "Disabled"
    private_link_service_network_policies_enabled = false
    service_endpoints                             = []
    subnet_delegation_name                        = ""
    subnet_service_delegation_name                = null
    subnet_service_delegation_actions             = null
  }
}

  depends_on = [azurerm_resource_group.this]
}

module "storage_account" {
  source = "git::https://github.com/divyasingh0/az_tf_module.git//demo_folder/storage?ref=e2eab019bf884c922b50fd17dfc5e7c5f3f3adf0"

  resource_name_config = {
    resource_type = "stg"
    application   = var.app_name
    environment   = var.environment
    region        = var.location
    cloud         = "az"
    instance      = "01"
    use_hyphen    = false
  }

  mandatory_tags = var.mandatory_tags

  storage_accounts = {
    primary = {
      rgname                           = var.resource_group_name
      instance                         = "01"
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

      network_rules = null
      cors_rules    = var.cors_rules

      resource_specific_tags = {
        backup-policy = "daily"
      }

      optional_tags = var.optional_tags

      custom_tags = merge(
        var.custom_tags,
        {
          Notes = var.notes
        }
      )
    }
  }

  depends_on = [azurerm_resource_group.this]
}