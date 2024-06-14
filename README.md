# terraform-mgc-kubernetes-cluster

![Static Badge](https://img.shields.io/badge/Magalu_provider-0.18.10-blue)
![License](https://img.shields.io/github/license/cloudscript-technology/terraform-mgc-kubernetes-cluster.svg)
![GitHub Release](https://img.shields.io/github/release/cloudscript-technology/terraform-mgc-kubernetes-cluster.svg)

## Description

This Terraform module creates and manages Kubernetes clusters on Magalu Cloud using the official `magalucloud/mgc` provider. It offers various configuration options through input variables to customize the cluster creation as needed.

## Features

- Creation of Kubernetes clusters on Magalu Cloud
- Configuration of node pools with auto-scaling options
- Support for bastion hosts for secure access to the cluster
- Option for server groups with anti-affinity policy

## Usage

### Requirements

- [Terraform](https://www.terraform.io/downloads.html) >= 0.14
- Magalu Cloud account

### Providers

```hcl
terraform {
  required_providers {
    mgc = {
      source = "magalucloud/mgc"
      version = "0.18.10"
    }
  }
}
```

### Example Configuration

```hcl
module "kubernetes_cluster" {
  source = "github.com/cloudscript-technology/terraform-mgc-kubernetes-cluster?ref=0.0.1"

  name                = "my-k8s-cluster"
  enabled_bastion     = true
  enabled_server_group = true

  # *** CAUTION *** Recreate cluster on change
  default_node_pools = [
    {
      name     = "pool-1"
      flavor   = "standard"
      replicas = 3
      auto_scale = {
        max_replicas = 5
        min_replicas = 1
      }
      tags = ["env:prod", "team:devops"]
      taints = [
        {
          effect = "NoSchedule"
          key    = "dedicated"
          value  = "db"
        }
      ]
    }
  ]

  node_pools = [
    {
      name     = "pool-2"
      flavor   = "standard"
      replicas = 3
      auto_scale = {
        max_replicas = 5
        min_replicas = 1
      }
      tags = ["env:prod", "team:devops"]
      taints = [
        {
          effect = "NoSchedule"
          key    = "dedicated"
          value  = "sys"
        }
      ]
    }
  ]
}
```

### Variables

| Name                  | Type   | Description                                                             | Default | Required |
|-----------------------|--------|-------------------------------------------------------------------------|---------|----------|
| `name`                | string | Name of the Kubernetes cluster                                          | n/a     | yes      |
| `description`         | string | A brief description of the Kubernetes cluster                           | null    | no       |
| `kubernetes_version`  | string | The native Kubernetes version for the cluster in 'vX.Y.Z' format        | null    | no       |
| `enabled_bastion`     | bool   | Enables the use of a bastion host for secure access to the cluster      | n/a     | yes      |
| `enabled_server_group`| bool   | Enables the use of a server group with anti-affinity policy             | false   | no       |
| `node_pools`          | list   | A list representing node pools within the Kubernetes cluster            | n/a     | yes      |

### Outputs

This module does not have defined outputs. Add outputs as needed to expose important cluster information.

## Contributions

Contributions are welcome! To contribute, follow these steps:

1. Fork this repository
2. Create a branch for your feature (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Create a new Pull Request

## License

This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details.

## Author

This module is maintained by [CloudScript Technology](https://github.com/cloudscript-technology).

## References

- [Magalu Cloud Provider](https://registry.terraform.io/providers/magalucloud/mgc/latest)
- [Terraform Documentation](https://www.terraform.io/docs)
