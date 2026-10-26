output "resource_group_name" {
  description = "Resource group created by this lab."
  value       = azurerm_resource_group.this.name
}

output "budget_name" {
  description = "Monthly budget resource name."
  value       = azurerm_consumption_budget_resource_group.monthly.name
}

output "budget_scope" {
  description = "Resource group ID monitored by the budget."
  value       = azurerm_consumption_budget_resource_group.monthly.resource_group_id
}
