# Readme - simple aws playbook

This a very simple ansible playbook for creating a single AWS EC2 instance

based upon https://developers.redhat.com/articles/2023/06/05/how-create-ec2-instance-aws-using-ansible-cli

see also https://medium.datadriveninvestor.com/devops-using-ansible-to-provision-aws-ec2-instances-3d70a1cb155f

to run this playbook import the keys as environment variables

```
export AWS_ACCESS_KEY=xxx
export AWS_SECRET_KEY=yyy
```

```
docker compose up -d

docker compose exec semaphore bash

# this logs in as ansible with correct path
sudo su - ansible 

mkdir -p /home/ansible/devel/gitrepos

cd /home/ansible/devel/gitrepos

git clone https://github.com/gallenc/COM614-cloud-computing.git

cd /home/ansible/devel/gitrepos/COM614-cloud-computing/workup/aws-ansible-examples/ansible-semaphore-localstack-example/ansible/aws/ansible-simple-1


```

```
ansible-playbook aws-playbook1.yml --ask-vault-pass
```

VERY IMPORTANT LOG IN TO AMAZON AND  DELETE THIS INSTANCE !!!

```
ansible-playbook aws-playbook1.yml --vault-password-file /share/password-client.sh
```