# Auto-created using setup.sh script
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "<>"
    container_name       = "tfstate"
    key                  = "env/dev.tfstate"
    use_azuread_auth     = true
  }
}
