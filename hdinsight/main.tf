resource "azurerm_storage_account" "demoSA" {
  name                     = var.storacc_name
  resource_group_name      = var.rg_name
  location                 = var.rg_location
  account_tier             = var.acc_tier
  account_replication_type = var.replication_type
}

resource "azurerm_storage_container" "demoSC" {
  name                  = var.storcont_name
  storage_account_name  = azurerm_storage_account.demoSA.name
  container_access_type = var.contaccess
}


resource "azurerm_hdinsight_hadoop_cluster" "demohadoop" {
  name                = var.hadoopclus_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  cluster_version     = var.clus_version
  tier                = var.clus_tier

  component_version {
    hadoop = var.hadoop_version
  }

  gateway {
    enabled  = true
    username = var.username
    password = var.password
  }

  storage_account {
    storage_container_id = azurerm_storage_container.demoSC.id
    storage_account_key  = azurerm_storage_account.demoSA.primary_access_key
    is_default           = true
  }

  roles {
    head_node {
      vm_size  = var.headnode_vmsize
      username = "acctestusrvm"
      password = "AccTestvdSC4daf986!"
    }

    worker_node {
      vm_size               = var.workernode_vmsize
      username              = "acctestusrvm"
      password              = "AccTestvdSC4daf986!"
      target_instance_count = 3
    }

    zookeeper_node {
      vm_size  = var.zoonode_vmsize
      username = "acctestusrvm"
      password = "AccTestvdSC4daf986!"
    }
  }
}
