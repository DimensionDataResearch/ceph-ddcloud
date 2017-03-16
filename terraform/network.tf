# Network configuration

data "ddcloud_networkdomain" "ceph" {
    name        = "${var.network_domain_name}"
    datacenter  = "AU10"
}

resource "ddcloud_vlan" "ceph_primary" {
    name        = "ceph-${var.cluster_name}-primary"
    description = "Primary VLAN for ${var.cluster_name} cluster."

    networkdomain       = "${data.ddcloud_networkdomain.ceph.id}"
    ipv4_base_address   = "${element(split("/", var.cluster_primary_network), 0)}"
    ipv4_prefix_size    = "${element(split("/", var.cluster_primary_network), 1)}"
}

resource "ddcloud_address_list" "clients" {
	name			= "Clients"
	ip_version		= "IPv4"

	addresses		= [ "${var.client_ip}" ]

	networkdomain	= "${data.ddcloud_networkdomain.ceph.id}"
}
