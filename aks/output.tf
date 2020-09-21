# Ouput values to be used in other modules.

output "rg_location" {
  value = "${azurerm_resource_group.demoRg.location}"
}

output "rg_name" {
  value = "${azurerm_resource_group.demoRg.name}"
}

output "vnet_id" {
  value = "${azurerm_virtual_network.demovnet.id}"
}

output "subnet_name" {
  value = "${azurerm_subnet.demoSubnet.name}"
}

output "subnet_id" {
  value = "${azurerm_subnet.demoSubnet.id}"
}