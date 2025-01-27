todo:
1. ansible tutorial with docker
2. discussion of pxe boot
3. configuration  of machines in cloud

# VM automation

[infrastructure automation tools with virtual machines in Azure](https://learn.microsoft.com/en-us/azure/virtual-machines/infrastructure-automation)

## configuring virtual machines

|config method           |local                   |Azure                    |AWS                     |Notes                   |
|:-----------------------|:-----------------------|:------------------------|:-----------------------|:-----------------------|
|gui manual              |                        |                         |                        |                        |
|CLI manual              |                        |                         |                        |                        |
|config file             |                        |                         |                        |                        |
|ansible / chef / puppet |                        |                         |                        |                        |
|terraform               |                        |                         |                        |                        |
|docker compose          |                        |                         |                        |                        |
|kubernetes              |                        |                         |                        |                        |
|RH OpenShift            |                        |                         |                        |                        |
|                        |                        |                         |                        |                        |

## virtualbox vagrant

hashicorp vagrant https://www.vagrantup.com/

https://stakkr.readthedocs.io/en/stable/   simple creation of docker compose

## terrform / opentofu

https://opentofu.org/

https://www.terraform.io/

## configuring containers

|config method           |local                   |Azure                    |AWS                     |Notes                   |
|:-----------------------|:-----------------------|:------------------------|:-----------------------|:-----------------------|
|gui manual              |                        |                         |                        |                        |
|CLI manual              |                        |                         |                        |                        |
|config file             |                        |                         |                        |                        |
|ansible / chef / puppet |                        |                         |                        |                        |
|terraform               |                        |                         |                        |                        |
|docker compose          |                        |                         |                        |                        |
|kubernetes              |                        |                         |                        |                        |
|RH OpenShift            |                        |                         |                        |                        |
|                        |                        |                         |                        |                        |


## Ansible examples and tutorial

Summary: this tutorial is intened to show how ansible can work if a machine with ssh is available

objective: install ansible using docker compose and use this to provision a server (implemented using another docker container)

This could be made to work

Summay: this tutorial is intend to show how pxe boot could be made to work where the machien is booted from bare metal and then configured using ansible
note that this cannot be done in docker without qemu as docker itself does not have a bios/pxe bot capability since the machine is not really a separate machine.

objective: install OS on docker container using pixi boot

https://github.com/qemus/qemu-docker - boots qemu machine from image

http://etherboot.org/wiki/qemu   How to use gPXE with QEMU

docker containers are already booted so pixi boot does not apply. Actually need nested virtualisation with pxi booting of lvm guest

https://cloudinfrastructureservices.co.uk/how-to-install-ansible-using-docker-compose-ubuntu-20-04-container/    How to Install Ansible using Docker Compose Ubuntu 20.04 (Container)

Ansible tutorial on linkedin Ansible Essential Training taught by Anthony Sequeira. https://www.linkedin.com/learning/ansible-essential-training-14199798
(note problem with example files - cannot be put on github)

https://github.com/ansible/ansible-examples/tree/master/wordpress-nginx  wordpress nginx example ansible

https://forum.ansible.com/t/install-an-operating-system-via-pxe-boot-and-ansible/7309/5   pixiboot to ansible

https://opensource.com/article/19/5/hardware-bootstrapping-ansible

https://jpetazzo.github.io/2013/12/07/pxe-netboot-docker/

https://gitlab.com/linkatedu/fogproject/blob/master/docker-compose.yml

https://thekelleys.org.uk/dnsmasq/doc.html  dnsmasq The DHCP subsystem supports DHCPv4, DHCPv6, BOOTP and PXE. 

https://github.com/ferrarimarco/docker-pxe
A Docker image serving as a standalone PXE (running dnsmasq). This server can be placed in an existing network infrastructure with an already configured DHCP server or in a network without any DHCP server.

https://www.linuxserver.io/blog/2019-12-16-netboot-xyz-docker-network-boot-server-pxe

https://github.com/linuxserver/docker-netbootxyz

# containers

https://www.docker.com/blog/lxc-vs-docker/  LXC vs docker


gpxe ethernet boot http://etherboot.org/wiki/index.php


# kubernetes tutorial

[Kubernetes Crash Course for Absolute Beginners](https://www.youtube.com/watch?v=s_o8dwzRlu4)

installing minikube https://minikube.sigs.k8s.io/docs/start/

(start docker desktop first)

minikube start --driver docker
minikube status
kubectl get node




