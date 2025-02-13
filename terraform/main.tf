provider "azurerm" {
  features {}
}

variable "location" {
  description = "The Azure region to deploy resources in"
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  default     = "newsverify-rg"
}

# Resource Group
resource "azurerm_resource_group" "newsverify" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = "development"
    project     = "NewsVerify"
  }
}

# Storage Account (for Terraform state files)
resource "azurerm_storage_account" "state" {
  name                     = "newsverifystatestorage"
  resource_group_name      = azurerm_resource_group.newsverify.name
  location                 = azurerm_resource_group.newsverify.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "development"
    project     = "NewsVerify"
  }
}

# App Service Plan
resource "azurerm_app_service_plan" "newsverify" {
  name                = "newsverify-appserviceplan"
  location            = azurerm_resource_group.newsverify.location
  resource_group_name = azurerm_resource_group.newsverify.name
  kind                = "FunctionApp"
  reserved            = true
  sku {
    tier = "Dynamic"
    size = "Y1"
  }

  tags = {
    environment = "development"
    project     = "NewsVerify"
  }
}

# Cosmos DB Account
resource "azurerm_cosmosdb_account" "newsverify" {
  name                = "newsverify-cosmos"
  resource_group_name = azurerm_resource_group.newsverify.name
  location            = azurerm_resource_group.newsverify.location
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = azurerm_resource_group.newsverify.location
    failover_priority = 0
  }

  tags = {
    environment = "development"
    project     = "NewsVerify"
  }
}

# Function App (Consumption Plan)
resource "azurerm_function_app" "newsverify" {
  name                       = "newsverify-func"
  location                   = azurerm_resource_group.newsverify.location
  resource_group_name        = azurerm_resource_group.newsverify.name
  app_service_plan_id        = azurerm_app_service_plan.newsverify.id
  storage_account_name       = azurerm_storage_account.state.name
  storage_account_access_key = azurerm_storage_account.state.primary_access_key
  os_type                    = "linux"
  version                    = "~4"

  depends_on = [
    azurerm_storage_account.state
  ]

  tags = {
    environment = "development"
    project     = "NewsVerify"
  }
}

# Application Insights
resource "azurerm_application_insights" "newsverify" {
  name                = "newsverify-appinsights"
  location            = azurerm_resource_group.newsverify.location
  resource_group_name = azurerm_resource_group.newsverify.name
  application_type    = "web"

  tags = {
    environment = "development"
    project     = "NewsVerify"
  }
}