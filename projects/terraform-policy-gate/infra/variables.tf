variable "resource_group_name" {
  description = "Name of the resource group for the lab."
  type        = string
  default     = "rg-policy-gate-lab"
}

variable "location" {
  description = "Azure region for the lab."
  type        = string
  default     = "uaenorth"
}

variable "storage_account_name" {
  description = "Globally unique lowercase Azure Storage account name (3-24 alphanumeric characters)."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "The storage account name must be 3-24 lowercase alphanumeric characters."
  }
}

variable "tags" {
  description = "Tags applied to resources."
  type        = map(string)
  default = {
    environment = "lab"
    managed_by  = "terraform"
    project     = "terraform-policy-gate"
  }
}
