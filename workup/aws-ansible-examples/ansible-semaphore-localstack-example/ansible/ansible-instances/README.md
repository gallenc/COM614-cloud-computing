# Ansible Playbooks for AWS: Creating, Managing, and Terminating EC2 Instances
based on https://blog.devops.dev/ansible-playbooks-for-aws-creating-managing-and-terminating-ec2-instances-5d383ac4ffd9

```
docker compose up -d

docker compose exec semaphore bash

sudo su - ansible # this logs in as ansible with correct path

mkdir -p /home/ansible/devel/gitrepos

cd /home/ansible/devel/gitrepos

git clone https://github.com/gallenc/COM614-cloud-computing.git

cd /home/ansible/devel/gitrepos/COM614-cloud-computing/workup/aws-ansible-examples/ansible-semaphore-localstack-example/ansible/ansible-instances
```

see also https://github.com/Jaraxal/ansible-aws-example#
