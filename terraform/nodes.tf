# Node (server) configuration

resource "ddcloud_server" "ceph_node" {
    count                   = "${var.cluster_node_count}"
    name                    = "${var.cluster_name}-node-${format(var.count_format, count.index + 1)}"
    description             = "${format("Node %d for %s cluster.", count.index+1, var.cluster_name)}"
    admin_password          = "${var.ssh_bootstrap_password}"
    auto_start              = "${var.node_auto_start}"

    memory_gb               = "${var.node_memory_gb}"
    cpu_count               = "${var.node_cpu_count}"

    # OS disk (/dev/sda) - expand to ${var.os_disk_size_gb}.
    disk {
        scsi_unit_id      = 0
        size_gb           = "${var.os_disk_size_gb}"
        speed             = "STANDARD"
    }

    # Data disk (/dev/sdb)
    disk {
        scsi_unit_id    = 1
        size_gb         = "${var.data_disk_size_gb}"
        speed           = "STANDARD"
    }

    networkdomain = "${data.ddcloud_networkdomain.ceph.id}"

    primary_network_adapter {
        vlan    = "${ddcloud_vlan.ceph_primary.id}"
        ipv4    = "${cidrhost(var.cluster_primary_network, var.cluster_first_node_host_number + count.index)}"
    }

    dns_primary     = "8.8.8.8"
    dns_secondary   = "8.8.4.4"

    image = "${var.os_image}"

    # For now, pack all roles onto each node.
    tag {
        name    = "roles"
        value   = "mons,agents,osds,mdss,rgws,nfss,restapis,rbdmirrors,clients,iscsigws"
    }
}

# The node must be publicly accessible for provisioning.
resource "ddcloud_nat" "ceph_node" {
	count			= "${var.cluster_node_count}"

	networkdomain	= "${data.ddcloud_networkdomain.ceph.id}"
	private_ipv4	= "${element(ddcloud_server.ceph_node.*.primary_adapter_ipv4, count.index)}"
}
resource "ddcloud_address_list" "ceph_nodes" {
	name			= "CephNodes"
	ip_version		= "IPv4"

	addresses		= [ "${ddcloud_nat.ceph_node.*.public_ipv4}" ]

	networkdomain	= "${data.ddcloud_networkdomain.ceph.id}"
}
resource "ddcloud_firewall_rule" "ceph_node_ssh_in" {
	name		= "nodes.ssh.inbound"
	placement   = "first"
	action		= "accept"
	enabled		= true

	ip_version  = "ipv4"
	protocol	= "tcp"

	source_address_list = "${ddcloud_address_list.clients.id}"

	destination_address_list    = "${ddcloud_address_list.ceph_nodes.id}"
	destination_port			= 22 # SSH

	networkdomain   = "${data.ddcloud_networkdomain.ceph.id}"
}

# Install an SSH key so that Ansible doesn't make us jump through hoops to authenticate.
resource "null_resource" "ceph_node_ssh" {
    count = "${var.cluster_node_count}"

	# Install our SSH public key.
	provisioner "remote-exec" {
		inline = [
			"mkdir -p ~/.ssh",
			"chmod 700 ~/.ssh",
			"echo '${file(var.ssh_public_key_file)}' > ~/.ssh/authorized_keys",
			"chmod 600 ~/.ssh/authorized_keys",
			"passwd -d root"
		]

		connection {
			type 		= "ssh"
			
			user 		= "root"
			password 	= "${var.ssh_bootstrap_password}"

			host 		= "${element(ddcloud_nat.ceph_node.*.public_ipv4, count.index)}"
		}
	}
}
