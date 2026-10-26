variable "subscription_id" {
  description = "Azure subscription ID used for this lab."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F-]{36}$", var.subscription_id))
    error_message = "subscription_id must be a valid GUID."
  }
}

variable "location" {
  description = "Azure region for the resource group."
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group used as the budget scope."
  type        = string
  default     = "rg-cost-guardrails-demo"
}

variable "budget_amount" {
  description = "Monthly budget amount in the subscription billing currency."
  type        = number
  default     = 50

  validation {
    condition     = var.budget_amount > 0
    error_message = "budget_amount must be greater than zero."
  }
}

variable "notification_email" {
  description = "Email address that receives budget threshold notifications."
  type        = string

  validation {
    condition     = can(regex("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$", var.notification_email))
    error_message = "Provide a valid notification email address."
  }
}

variable "tags" {
  description = "Tags applied to the resource group."
  type        = map(string)
  default = {
    environment = "lab"
    managed_by  = "terraform"
    project     = "azure-cost-guardrails"
  }
}
