provider "azurerm" {
    version = "~> 2.20.0"
    features {}
  }

# AKS Cluster Network
module "aks" {
  source              = "./aks"
  rg_name             = "demorg2"
  rg_location         = "centralus"
  Vnet_name           = "aksvnet001"
  Vnet_addr           = ["10.0.0.0/16"]
  subnet_name         = "akssubnet001"
  subnet_addr         = ["10.0.6.0/24"]
  cluster_name        = "demoakscluster1"
  dns_prefix          = "demoaks"
  node_name           = "default"
  node_count          = "1"
  vm_size             = "Standard_B2s"
  network_plugin      = "azure"
  service_cidr        = "10.0.0.0/26"
  dns_service_ip      = "10.0.0.10"
  docker_bridge_cidr  = "172.17.0.1/16"
}

#Hdinsights module
module "hdinsight"{
  source              = "./hdinsight"
  storacc_name        = "hdstoracc2201"
  rg_name             = "module.aks.rg_name"
  rg_loc              = "module.aks.rg_location"
  acc_tier            = "Standard"
  replication_type    = "LRS"
  storcont_name       = "hdcontainer"
  contaccess          = "private"
  hadoopclus_name     = "hdclusterdemo1"
  clus_version        = "3.6"
  clus_tier           = "Standard"
  hadoop_version      = "2.7"
  username            = "admin"
  password            = "P@ssw0rd@123456"
  headnode_vmsize     = "Standard_D3_V2"
  workernode_vmsize   = "Standard_D4_V2"
  zoonode_vmsize      = "Standard_D3_V2"
}
