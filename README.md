# Ceph deployment for Dimension Data's MCP

Terraform configuration and Ansible playbooks to deploy Ceph in MCP 2.0.

This is a work-in-progress, please [create an issue](https://github.com/DimensionDataResearch/ceph-ddcloud/issues/new) if you have questions, requests, or would like to contribute :-)

## Getting started

1. `python ansible/patch-ceph.py`
2. Customise `terraform/main.tf` and `ansible/ceph/group_vars/*.yml` as required
3. `cd terraform`
4. `terraform apply`
5. `terraform refresh`
6. `cd ../ansible/ceph`
7. `ansible-playbook ../playbooks/01_ansible_bootstrap.yml`
8. `ansible all -m ping`
9. `ansible-playbook ../playbooks/02_server_init.yml`
10. `ansible-playbook ceph.yml`

## Notes

* Before you start, ensure that the `ansible/ceph/fetch` directory is not already present.
