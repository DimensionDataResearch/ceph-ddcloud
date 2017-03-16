provider "ddcloud" {
    region = "AU"
}

# The local client's public (external) IPv4 address.
#
# Supply this value in terraform.tfvars.
variable "client_ip" { }

# The name of the network domain where Ceph will be deployed.
variable "network_domain_name" { default = "Ceph Demo" }

# The cluster name (used as a prefix / suffix for resource uniqueness).
variable "cluster_name" { default = "dev" }

# The number of nodes in the cluster.
variable "cluster_node_count" { default = 3 }

# The host number (within in the cluster's network) of the first node.
variable "cluster_first_node_host_number" { default = 20 }

# The cluster's primary network.
variable "cluster_primary_network" { default = "10.5.50.0/24" }

# The name or Id of the image used to create virtual machines.
variable "os_image" { default = "Ubuntu 14.04 2 CPU" }

# Expose servers via public IP addresses (enable firewall ingress rules)?
variable "expose_servers" { default = false }

# Automatically start server nodes after they are deployed?
variable "node_auto_start" { default = true }

# The amount of memory (in GB) allocated to each node.
variable "node_memory_gb" { default = 8 }

# The number of CPUs allocated to each node.
variable "node_cpu_count" { default = 2 }

# The size of the OS (root) volume for all deployed servers in the cluster.
variable "os_disk_size_gb" { default = 20 }

# The size of the data volume for all deployed servers in the cluster that need a separate volume for data.
variable "data_disk_size_gb" { default = 50 }

# The initial root password for machines in the cluster (used to bootstrap key-based SSH authentication).
variable "ssh_bootstrap_password" { default = "sn4uSag3s!" }

# The public key to configure for SSH authentication to machines in the cluster.
variable "ssh_public_key_file" { default = "~/.ssh/id_rsa.pub" }

#########
# Private

variable "count_format" { default = "%02d" }
