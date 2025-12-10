terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "sttfstate007"
    container_name       = "vmcontainer"
    key                  = "windowsvm.tfstate"
  }
}



