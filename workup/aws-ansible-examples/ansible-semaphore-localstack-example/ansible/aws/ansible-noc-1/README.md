# Scripts for creating a NOC

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

running in semaphore


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
```
