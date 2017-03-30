#!/usr/bin/env python

import glob
import os
import shutil

from ConfigParser import ConfigParser
from os import path

INVENTORY_PLUGIN = "../plugins/inventory/terraform-inventory.py"

base_dir = path.dirname(__file__)
ansible_cfg_path = path.join(
    base_dir, "ceph/ansible.cfg"
)

# Ensure Ansible uses our custom inventory plugin.
print("Patching '{}'...".format(ansible_cfg_path))

config = ConfigParser()
config.read(ansible_cfg_path)
config.set("defaults", "hostfile", INVENTORY_PLUGIN)
with open(ansible_cfg_path, "w") as ansible_cfg:
    config.write(ansible_cfg)

# Copy group_vars files for our default configuration.
print("Populating default group variables...")

group_vars_source = path.join(
    base_dir, "ddcloud_group_vars/*.yml"
)
group_vars_target = path.join(
    base_dir, "ceph/group_vars"
)
for source_file in glob.glob(group_vars_source):
    target_file = path.join(
        group_vars_target,
        path.basename(source_file)
    )

    if path.exists(target_file):
        print("{}: Already present.".format(
            path.basename(target_file)
        ))

        continue

    shutil.copyfile(source_file, target_file)
    print("{}: Copied.".format(
        path.basename(source_file)
    ))

print("Done.")
