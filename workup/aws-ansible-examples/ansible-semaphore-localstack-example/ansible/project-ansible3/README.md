cd /home/ansible/devel/gitrepos/COM614-cloud-computing/workup/aws-ansible-examples/ansible-semaphore-localstack-example/ansible/ansible-aws-example# README

To run this in virtual machine go to the location of project in the repo

```
# become an ansible user 
sudo su ansible

docker compose up -d

docker compose exec semaphore bash

sudo su - ansible # this logs in as ansible with correct path

mkdir -p /home/ansible/devel/gitrepos

cd /home/ansible/devel/gitrepos

git clone https://github.com/gallenc/COM614-cloud-computing.git

cd /home/ansible/devel/gitrepos/COM614-cloud-computing/workup/aws-ansible-examples/ansible-semaphore-localstack-example/ansible/project-ansible3

# run exercise
ansible -i inventory.ini all -m ping

ansible-playbook -i inventory.ini install_apache.yml

ansible-playbook -i inventory.ini uninstall_apache.yml

# see https://stackoverflow.com/questions/57919339/how-to-run-ansible-playbook-using-a-public-ssh-key
# running within semaphore account but using sudo/root allows ansible keys to be used from ansible account
cd /home/ansible/devel/gitrepos/COM614-cloud-computing/workup/aws-ansible-examples/ansible-semaphore-localstack-example/ansible/project-ansible3

sudo /opt/semaphore/apps/ansible/11.1.0/venv/bin/ansible  -i inventory.ini all -m ping


ansible-playbook -i inventory.ini roles/load-ssh-keys/main.yml
```



