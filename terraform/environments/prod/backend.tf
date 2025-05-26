terraform {
  backend "azurerm" {
    resource_group_name  = "terraform1"
    storage_account_name = "terraformmlopsl34rsuxr"
    container_name       = "tfstate"
    key                  = "env/prod.tfstate"
    use_azuread_auth     = true
  }
}
