data "digitalocean_kubernetes_versions" "current" {}

resource "digitalocean_kubernetes_cluster" "k8-cluster" {
  name    = "k8-cluster"
  region  = "fra1"
  version = data.digitalocean_kubernetes_versions.current.latest_version

  node_pool {
    name       = "k8-node-pool"
    size       = "s-2vcpu-2gb"
    node_count = 2
  }
}