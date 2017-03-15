provider "ddcloud" {
    region = "AU"
}

# The name or Id of the image used to create virtual machines.
variable "os_image" { default = "CentOS 7 64-bit 2 CPU" }

# Expose servers via public IP addresses (enable firewall ingress rules)?
variable "expose_servers" { default = false }

# The cluster VLAN's IP network base address.
variable "cluster_vlan_address_base" { default = "10.5.50.0" }

# The cluster VLAN's IP network prefix size.
variable "cluster_vlan_prefix_size" { default = 24 }

# The last quad of the first IP address used by the cluster (i.e. without cluster_vlan_address_base).
variable "cluster_vlan_address_start" { default = 20 }

# Automatically start servers after they are deployed?
variable "server_auto_start" { default = true }

# The size of the OS (root) volume for all deployed servers in the cluster.
variable "os_disk_size_gb" { default = 10 }

# The size of the data volume for all deployed servers in the cluster that need a separate volume for data.
variable "data_disk_size_gb" { default = 50 }

# The initial root password for machines in the cluster (later, we'll use this password to connect via SSH and switch to using a key file).
variable "initial_root_password" { default = "sn4uSag3s!" }

# The public key to configure for SSH authentication to machines in the cluster.
variable "ssh_public_key_file" { default = "~/.ssh/id_rsa.pub" }
