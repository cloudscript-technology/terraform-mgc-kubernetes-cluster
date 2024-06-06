terraform {
  required_providers {
    mgc = {
      source = "magalucloud/mgc"
      version = "0.18.10"
    }
  }
}

resource "mgc_kubernetes_cluster" "cluster" {
  # Required
  name = var.name
  enabled_bastion = var.enabled_bastion
  node_pools = var.node_pools

  # Optionals
  version = var.kubernetes_version
  description = var.description
  enabled_server_group = var.enabled_server_group
}