provider "azurerm" {
    version = "2.5.0"
    features {}
}

terraform {
    backend "azurerm" {
        resource_group_name  = "tf_rg_blobstorage"
        storage_account_name = "tfstorageashfakcode"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}


resource "azurerm_resource_group" "tf_test" {
  name = "tfmainrg"
  location = "eastus"
}


resource "azurerm_app_service_plan" "az_app_svplan" {
  name                = "react-appserviceplan"
  location            = azurerm_resource_group.tf_test.location
  resource_group_name = azurerm_resource_group.tf_test.name

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "az_app_sv" {
  name                = "react-app-service"
  location            = azurerm_resource_group.tf_test.location
  resource_group_name = azurerm_resource_group.tf_test.name
  app_service_plan_id = azurerm_app_service_plan.az_app_svplan.id
}