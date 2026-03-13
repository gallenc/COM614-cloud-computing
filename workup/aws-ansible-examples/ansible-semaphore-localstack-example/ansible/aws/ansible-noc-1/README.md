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

```
ansible-playbook -i inventory/dev/hosts.ini playbook.yaml --ask-vault-pass

ansible-inventory -i inventory/dev/hosts.ini --list   --ask-vault-pass

```