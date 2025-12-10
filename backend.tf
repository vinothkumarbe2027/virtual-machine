terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "vmcontainer"
    container_name       = "vmcontainer"
    key                  = "windowsvm.tfstate"
  }
}
