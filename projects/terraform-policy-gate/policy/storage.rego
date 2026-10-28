package main

deny contains msg if {
  input.resource_type == "azurerm_storage_account"
  input.https_traffic_only_enabled != true
  msg := "Storage account must enforce HTTPS-only traffic."
}

deny contains msg if {
  input.resource_type == "azurerm_storage_account"
  input.min_tls_version != "TLS1_2"
  msg := "Storage account must require TLS 1.2 or later."
}

deny contains msg if {
  input.resource_type == "azurerm_storage_account"
  input.public_network_access_enabled != false
  msg := "Storage account public network access must be disabled."
}

deny contains msg if {
  input.resource_type == "azurerm_storage_account"
  input.allow_nested_items_to_be_public != false
  msg := "Anonymous public access to nested storage items must be disabled."
}

deny contains msg if {
  input.resource_type == "azurerm_storage_account"
  input.shared_access_key_enabled != false
  msg := "Shared key authorization must be disabled where Entra ID authorization is supported."
}
