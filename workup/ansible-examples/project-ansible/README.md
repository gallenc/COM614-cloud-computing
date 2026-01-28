# README

To run this in virtual machine go to the location of project in the repo
(somewhat based on https://www.liquidweb.com/blog/install-ansible-almalinux/)


```
# become an ansible user 
sudo su ansible

cd /home/ansible/devel/gitrepos/COM614-cloud-computing/workup/ansible-examples/project-ansible


# run exercise
ansible -i inventory.ini all -m ping

```



