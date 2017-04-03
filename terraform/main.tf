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
variable "cluster_name" { default = "ceph" }

# The number of monitor nodes in the cluster.
variable "cluster_node_count_mon" { default = 3 }

# The number of OSD nodes in the cluster.
#
# If you change this, you MUST also update ceph_conf_overrides/global/"osd pool default size" in group_vars/all.yml.
variable "cluster_node_count_osd" { default = 3 }

# The host number (within in the cluster's network) of the first admin node.
variable "cluster_first_host_admin" { default = 20 }

# The host number (within in the cluster's network) of the first monitor node.
variable "cluster_first_host_mon" { default = 30 }

# The host number (within in the cluster's network) of the first OSD node.
variable "cluster_first_host_osd" { default = 40 }

# The cluster's primary network.
variable "cluster_primary_network" { default = "10.5.50.0/24" }

# The name or Id of the image used to create virtual machines.
variable "os_image" { default = "CentOS 7 64-bit 2 CPU" }

# Expose servers via public IP addresses (enable firewall ingress rules)?
variable "expose_servers" { default = false }

# Automatically start server nodes after they are deployed?
variable "node_auto_start" { default = true }

# The amount of memory (in GB) allocated to each node.
variable "node_memory_gb" { default = 8 }

# The number of CPUs allocated to each node.
variable "node_cpu_count" { default = 2 }

# The size of the OS (root) volume for all deployed servers in the cluster.
#
# Expanding the root volume via Ansible is possible, but a bit of a pain. I'd avoid doing so if possible (so make sure this matches the disk size in the OS image).
variable "os_disk_size_gb" { default = 10 }

# The size of the data volume for all deployed servers in the cluster that need a separate volume for data.
variable "data_disk_size_gb" { default = 50 }

# The initial root password for machines in the cluster (used to bootstrap key-based SSH authentication).
variable "ssh_bootstrap_password" { default = "sn4uSag3s!" }

# The public key to configure for SSH authentication to machines in the cluster.
variable "ssh_public_key_file" { default = "~/.ssh/id_rsa.pub" }

#########
# Private

variable "count_format" { default = "%02d" }
