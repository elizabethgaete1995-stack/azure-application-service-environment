terraform {
  backend "azurerm" {
    use_azuread_auth     = true
    use_cli              = true
    resource_group_name  = "rg-tfstate-poc-01"
    storage_account_name = "sttfstatepoc1215003353"
    container_name       = "tfstate"
  }
}
