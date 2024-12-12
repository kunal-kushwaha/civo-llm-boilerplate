
resource "civo_kubernetes_cluster" "cluster" {
    name = var.cluster_name
    
    # Connect to the network & firewall
    firewall_id = civo_firewall.firewall.id
    network_id  = civo_network.network.id
    
    # Cluster type must be talos for GPU support
    cluster_type = "talos"
    
    # attach one 
    pools {
        size = var.cluster_node_size
        node_count = var.cluster_node_count
    }

    # specify a timeout for the cluster creation
    timeouts {
        create = "10m"
    }
}

# Create a local file with the kubeconfig
resource "local_file" "cluster-config" {
  content              = civo_kubernetes_cluster.cluster.kubeconfig
  filename             = "${path.module}/kubeconfig"
  file_permission      = "0600"
  directory_permission = "0755"
}
