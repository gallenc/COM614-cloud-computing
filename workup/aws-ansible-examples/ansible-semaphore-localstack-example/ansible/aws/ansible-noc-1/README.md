# Scripts for creating a NOC

This project creates an environment for hosting a variety of services which are started using docker compose.
The project can be used in semaphore-ui or locally in the ansible account.

## Project Overview

The [ansible-noc-1/aws](../ansible-noc-1/aws) folder contains a playbook for creating EC2 instances in AWS and setting up a dns domain names using route53.
These machines are minimally provisioned with an ansible account so that the common playbook can provision them after they are created.

The [ansible-noc-1/common](../ansible-noc-1/common) folder contains a playbook for creating and populatiing an inventory of instances so that they will run docker compose base services under systemd.
The [ansible-noc-1/common](../ansible-noc-1/common) files are generic and not limited to machines created using any particular cloud provider.
They are designed to run using the ansible user account and assume that the remote machines will accept certificate based ssh logins from the ansible account.


# Running project locally

file layout based upon https://oneuptime.com/blog/post/2026-02-21-how-to-organize-ansible-inventory-with-group-vars-directory/view

Create a vault file containing your aws access key and secret keys. 
You will be prompted to enter and confirm a password and an editor will open

```
ansible-vault create vault.yml
New Vault password: 
Confirm New Vault password:
```
add the secrets to the vault file

```
# this is an example vault file for aws access keys
# create: ansible-vault create group-vars/vault.yml
# add the values, keep your secret key and checkin the file. 
# edit: ansible-vault edit group_vars/all/vault.yml

aws_access_key: ""

aws_secret_key: "" 
```

You can edit or view a vault file using the password using

```
ansible-vault edit vault.yml
ansible-vault view vault.yml

```

running scripts in ansible account in semaphore container 


```
docker compose up -d

docker compose exec semaphore bash

# this logs in as ansible with correct path
sudo su - ansible 

mkdir -p /home/ansible/devel/gitrepos

cd /home/ansible/devel/gitrepos

git clone https://github.com/gallenc/COM614-cloud-computing.git

cd /home/ansible/devel/gitrepos/COM614-cloud-computing/workup/aws-ansible-examples/ansible-semaphore-localstack-example/ansible/aws/ansible-noc-1


```

## AWS playbooks to provision AWS ec2

```
ansible-playbook -i aws/inventory/dev/hosts.ini aws/playbooks/createAwsProject.yaml --ask-vault-pass

ansible-playbook -i aws/inventory/dev/hosts.ini aws/playbooks/startAwsProject.yaml --ask-vault-pass

ansible-playbook -i aws/inventory/dev/hosts.ini aws/playbooks/stopAwsProject.yaml --ask-vault-pass

ansible-playbook -i aws/inventory/dev/hosts.ini aws/playbooks/terminateAwsProject.yaml --ask-vault-pass

ansible-inventory -i aws/inventory/dev/hosts.ini --list   --ask-vault-pass

```

## Common playbooks to provision cloud - independent of provider (post machine creation)

check main cloud ansible is reachable

```
ansible -i common/inventory/dev/hosts.ini all -m ping

ansible-inventory -i common/inventory/dev/hosts.ini install-docker-compose-services.yaml 

ansible-inventory -i common/inventory/dev/hosts.ini start-docker-compose-service.yaml

ansible-inventory -i common/inventory/dev/hosts.ini install-docker-systemd.yaml 

ansible-inventory -i common/inventory/dev/hosts.ini stop-docker-compose-service.yaml

```

# running in ansible-ui

http://localhost:3000/


