# CloudStack Vagrant Ansible Example

This example is an attempt to get a small single node cloud stack implementation running on VirtualBox and provisioned with Vagrant

# Vagrant

[vbproject3](../cloudstack-vagrant-ansible/vbproject3) contains the vagrant project.
This is very similar to the projects we saw earlier.

the key changes are 

1. Adding nested virtualisation to the virtual machine in Vagrantfile

```
vb.customize ["modifyvm", :id, "--nested-hw-virt", "on"] # enables vt-x nested virtualisation
```

2. cloudstack-config.sh

* adds some ansible depencencies
* sets the security key checking to LEGACY
* checks out this project into the machine

# Ansible provisioning of Cloudstack

THe vagrant project does not automatically provision cloud stack.
To do this you need to log into the running machine and run the ansible playbook in [ansible-cloudstack](../cloudstack-vagrant-ansible/vbproject3)

The ansible playbook has been cloned from Matheus-Thurler's project 

* ansible-cloudstack  cloned from https://github.com/Matheus-Thurler/ansible-cloudstack  (Commit 6ed14e3)

Several modifications have been made to allow it to run on Vagrant

1. firewalld configuration is omitted and firewalld is not used. This interferes with vagrant.
2. the network for cloudstack runs on a bridge `cloudbr0` which is connected to the VirtualBox private host only network on 192.168.56.35
3. the NAT netowork is used to access the internet. 
 
## To run example

```
vagrant up

vagrant ssh cloudstack_controller

sudo su ansible

cd /home/ansible/devel/gitrepos/COM614-cloud-computing/workup/cloudstack-vagrant-ansible/ansible-cloudstack

ansible-playbook -i inventory.ini cloudstack-install.yml

```

when running see the UI at

http://192.168.56.35:8080/client/

username admin

password password

Note htat the ZONE_SETUP needs adapted to the differnt netowrk.
Also you may need to turn on routing in the host to allow traffic to the internet

Note that the platform has an AWS API mapping capability 
aws api mapping https://docs.cloudstack.apache.org/en/4.17.0.0/installguide/optional_installation.html






