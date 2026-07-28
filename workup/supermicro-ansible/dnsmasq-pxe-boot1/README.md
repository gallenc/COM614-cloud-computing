# configure dnsmasq and pxe boot sources

## dnsmasq example 

primarily taken from ansible by example
see https://www.ansiblebyexample.com/articles/ansible-dnsmasq-dhcp-dns-network-services

## tftboot example

Based on: How to Use Ansible to Provision Bare Metal Servers 

https://oneuptime.com/blog/post/2026-02-21-how-to-use-ansible-to-provision-bare-metal-servers/view

Learn how to automate bare metal server provisioning with Ansible from PXE boot and IPMI management to full OS configuration. Nawaz Dhandala By @nawazdhandala Feb 21, 2026

all of the above configurations have been merged into this example.

# running


```
ansible-playbook -i inventory/dev/hosts.ini playbooks/setup-pxe-server.yml
```





