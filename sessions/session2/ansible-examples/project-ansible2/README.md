# README

To run this in virtual machine go to the location of project in the repo
(somewhat based on hhttps://www.liquidweb.com/blog/install-ansible-almalinux/)


```
# become an ansible user 
sudo su ansible

cd /home/ansible/devel/gitrepos/COM614-cloud-computing/sessions/session2/ansible-examples/project-ansible2

# run exercise
ansible -i inventory.ini all -m ping

# run exercise
ansible-playbook -i inventory.ini playbook.yml


```



