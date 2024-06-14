variable "name" {
  type        = string
  description = "Kubernetes cluster name"
}

variable "description" {
  type        = string
  description = "A brief description of the Kubernetes cluster."
  default     = null
}

variable "kubernetes_version" {
  type        = string
  description = "The native Kubernetes version of the cluster. Please specify the Kubernetes version using the standard 'vX.Y.Z' format."
  default     = null
}

variable "enabled_bastion" {
  type        = bool
  description = "Enables the use of a bastion host for secure access to the cluster."
}

variable "enabled_server_group" {
  type        = bool
  description = "Enables the use of a server group with anti-affinity policy during the creation of the cluster and its node pools."
  default     = false
}

variable "node_pools" {
  type        = list(object({
    name     = string
    flavor   = string
    replicas = number
    auto_scale = optional(object({
      max_replicas = optional(number)
      min_replicas = optional(number)
    }))
    tags = optional(list(string))
    taints = optional(list(object({
      effect = string
      key    = string
      value  = string
    })))
  }))
  description = " An array representing a set of nodes within a Kubernetes cluster."
}