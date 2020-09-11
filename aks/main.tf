
## Resource Group Creation ##
resource "azurerm_resource_group" "demoRg" {
  name     = var.rg_name
  location = var.rg_location
}

## Virtual Network Creation ##
resource "azurerm_virtual_network" "demovnet" {
  name                = var.Vnet_name
  address_space       = var.Vnet_addr
  location            = azurerm_resource_group.demoRg.location
  resource_group_name = azurerm_resource_group.demoRg.name
}

## Subnet Creation ##
resource "azurerm_subnet" "demoSubnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.demoRg.name
  virtual_network_name = azurerm_virtual_network.demovnet.name
  address_prefixes     = var.subnet_addr
}

## AKS kubernetes cluster ##
resource "azurerm_kubernetes_cluster" "demoaks" { 
  name                = var.cluster_name
  resource_group_name = azurerm_resource_group.demoRg.name
  location            = azurerm_resource_group.demoRg.location
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = var.node_name
    node_count = var.node_count
    vm_size    = var.vm_size
    vnet_subnet_id  = azurerm_subnet.demoSubnet.id
  }

  network_profile {
    network_plugin     = var.network_plugin
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
    docker_bridge_cidr = var.docker_bridge_cidr
  }
   identity {
          type = "SystemAssigned"
  } 
}