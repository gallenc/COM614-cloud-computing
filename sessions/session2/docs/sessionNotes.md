[Main Menu](../../../sessions/README.md) |[session12](../../session12/) | [Session 2 Notes](../docs/sessionNotes.md)

# Session 2 Notes


## Cloud Deployment Design Objectives

* Our objective in devops is to do as much testing on local development environments before committing to using cloud resources for testing. 
  In order to do this, we need to be able to quickly spin up a test environment locally and provision it as we would a cloud resource.
* Our test environment needs to be automated and replicatable quickly with minimal manual intervention. 
* We also need to ensure that there is as little difference as possible between the cloud and the local test environment. 
* The overall cost of testing and deployment and the production costs need to be minimised.
* The overall objective is to use infrastructure as code - with a much hands free automation as possible. 
P We need to consider whether this could be provisioned as a service from the AWS market place with no manual intervention.


## Cloud / VM Orchestration Options (on AWS)


| Packaging and deployment Technology | Local Test Environment                                | Cloud Test / Production Environment                 | Comments                                  |
|:------------------------------------|:------------------------------------------------------|:----------------------------------------------------|:------------------------------------------|
| Virtual Machines                    |Vagrant and shell scripts and/or ansible               | EC2 Cloud Formation, Terraform, Ansible (cloud provider's api). | Simple but slow to deploy and 'clunky' |
| Virtual Machines with Docker        |Vagrant with ansible and docker compose                | EC2 instance with Docker compose                   | More flexable but mixes technologies so complex        |
| Docker Compose                      | Docker Desktop / docker compose /                     | ECS Elastic Container Service                       | Very flexable but expensive               |
| Kubernetes                          | Docker Desktop / k8s etc kubernetes / helm            | EKS Elastic Kubernetes Service or VM hosted kubernetes  | Kubernetes is very feature rich but expensive and resource intensive |
|                                     |                                                       |                                                     |                                           |

# Local provisioning and testing

We want to be able to provision our machines using Ansible whether they are provided in the cloud or on our local VirtualBox platform.
That way we know that most of the configuration is similar locally and remotely.

Our previous Vagrant examples are designed to run on Windows and use shell scripts to provision the machines on first boot. 
Vagrant can also run with other provisioners such as Ansible or chef but these need to be installed on the host machine or installed on each of the guests.

Unfortunately Ansible cannot run directly in Windows but several options have been proposed to run Ansible provisioning as part of a vagrant build. 
One option is to install Ansible on windows WSL.
A second option is to install Ansible on all the guests.
A third option is to spin up an ansible controller guest and use this to provison the other guests.

All of these options are discussed in the following posts.

* Vagrant and Windows Subsystem for Linux https://developer.hashicorp.com/vagrant/docs/other/wsl  
* A Multi-VM Vagrant environment for Developing and Testing Ansible Roles https://github.com/coglinev3/ansible-development
* Using Ansible through Windows 10's Subsystem for Linux https://www.jeffgeerling.com/blog/2016/using-ansible-through-windows-10s-subsystem-linux/
* Vagrant with Ansible Provisioner on Windows https://gist.github.com/tknerr/291b765df23845e56a29  

The vagrant documentation provides examples of running ansible as part of a vagrant build see https://developer.hashicorp.com/vagrant/docs/provisioning/ansible_intro


# docker compose 

see https://unix.stackexchange.com/questions/206315/whats-the-difference-between-usr-lib-systemd-system-and-etc-systemd-system
The expectation is that /usr/lib/systemd/system is a directory that should only contain systemd unit files which were put there by the package manager (YUM/DNF/RPM/APT/etc).

Files in /etc/systemd/system are manually placed here by the operator of the system for ad-hoc software installations that are not in the form of a package