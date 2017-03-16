# Ceph deployment for Dimension Data's MCP

Terraform configuration and Ansible playbooks to deploy Ceph in MCP 2.0.

1. Customise `terraform/main.tf` and `ansible/ceph/group_vars/all.yml` as required.
2. `cd terraform`
3. `terraform apply`
4. `terraform refresh`
5. `cd ../ansible/ceph`
6. `ansible all -m ping`
7. `ansible-playbook ceph.yml`

## Notes

* Before you start, ensure that the `ansible/ceph/fetch` directory is not already present.
