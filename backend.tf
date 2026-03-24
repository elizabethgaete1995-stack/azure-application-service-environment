terraform {
  backend "azurerm" {
    use_azuread_auth     = true
    use_cli              = true
    container_name       = "tfstate"
    storage_account_name = "sttfstatepoc1215003353"
  }
}
