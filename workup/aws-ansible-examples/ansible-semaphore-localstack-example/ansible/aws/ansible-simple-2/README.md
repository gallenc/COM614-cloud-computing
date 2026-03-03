# README

based on From Creation to Deletion: Managing AWS Resources with Ansible Playbooks
https://medium.com/@m.qasimnauman/creating-and-managing-with-ansible-c6dafe407d92


```
docker compose up -d

docker compose exec semaphore bash

sudo su - ansible # this logs in as ansible with correct path

mkdir -p /home/ansible/devel/gitrepos

cd /home/ansible/devel/gitrepos

git clone https://github.com/gallenc/COM614-cloud-computing.git

cd /home/ansible/devel/gitrepos/COM614-cloud-computing/workup/aws-ansible-examples/ansible-semaphore-localstack-example/ansible/aws/ansible-simple-2

```

```
ansible-playbook create-aws-instances.yml --ask-vault-pass
```

```
ansible-playbook create-aws-instances.yml --vault-password-file /share/password-client.sh
```

VERY IMPORTANT LOG IN TO AMAZON AND  DELETE THIS INSTANCE !!!

```
ansible-playbook terminate-aws-instances.yml --vault-password-file /share/password-client.sh
```