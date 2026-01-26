#!/bin/bash

# This script could be included in initial machine configuration Vagrantfile.
# It contains some extra configurations to start ansible

#set -x

# see How to Install and Configure Ansible on AlmaLinux https://www.liquidweb.com/blog/install-ansible-almalinux/

# dnf update -y

sudo dnf install -y epel-release

sudo dnf install ansible-core -y


