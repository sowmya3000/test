variable "rg_name"{
type = string
}

variable "rg_location"{
type = string
}

variable "Vnet_name"{
    type = string
}

variable "Vnet_addr"{
    type = list
}

variable "subnet_name"{
    type = string
}

variable "subnet_addr"{
    type = list
}

variable "cluster_name"{
    type = string
}

variable "dns_prefix"{
    type = string
}

variable "node_name"{
    type = string
}

variable "node_count"{
    type = number
}

variable "vm_size"{
    type = string
}

variable "network_plugin"{
    type = string
}

variable "service_cidr"{
    type = string
}

variable "dns_service_ip"{
    type = string
}

variable "docker_bridge_cidr"{
    type = string
}