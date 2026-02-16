cd /home/ansible/devel/gitrepos/COM614-cloud-computing/workup/aws-ansible-examples/ansible-semaphore-localstack-example/ansible/ansible-aws-example# README

To run this in virtual machine go to the location of project in the repo
(somewhat based on https://www.liquidweb.com/blog/install-ansible-almalinux/)


```
# become an ansible user 
sudo su ansible

cd /home/ansible/devel/gitrepos/COM614-cloud-computing/workup/aws-ansible-examples/ansible-semaphore-localstack-example/ansible/project-ansible3


# run exercise
ansible -i inventory.ini all -m ping

```



