# Ceph deployment for Dimension Data's MCP

Terraform configuration and Ansible playbooks to deploy Ceph in MCP 2.0.

If you have questions, requests, or would like to contribute, please please [create an issue](https://github.com/DimensionDataResearch/ceph-ddcloud/issues/new) because we'd love to hear from you :-)

## Getting started

1. `python ansible/patch-ceph.py`
2. Customise [terraform/main.tf](terraform/main.tf) and `*.yml` in [ansible/ceph/group_vars](ansible/ddcloud_group_vars) as required
3. Run `curl https://api.ipify.org`, and add the resulting IP address to `terraform/terraform.tfvars` as `client_ip` (create this file if it does not already exist)
4. `cd terraform`
5. `terraform apply`
6. `terraform refresh`
7. `cd ../ansible/ceph`
8. `ansible-playbook ../playbooks/01_ansible_bootstrap.yml`
9. `ansible all -m ping`
10. `ansible-playbook ../playbooks/02_server_init.yml`
11. `ansible-playbook ceph.yml`

## Notes

* To ensure a new (from-scratch) cluster deployment, before you start ensure that the `ansible/ceph/fetch` directory is not already present.
* Additional roles can be added to the monitor or OSD nodes by customising the `roles` key under `ddcloud_server` in [terraform/mon_nodes.tf](terraform/mon_nodes.tf) and / or [terraform/osd_nodes.tf](terraform/osd_nodes.tf).  
  For a list of valid roles, see [ansible/ceph/ceph.yml](ansible/ceph/ceph.yml).