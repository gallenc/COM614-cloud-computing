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
```

# using ssh-agent
echo "$(sudo cat /home/ansible/.ssh/id_rsa)" | ssh-add -

* https://stackoverflow.com/questions/54991392/using-ansible-vault-for-ansibles-ssh-keyfile  really good
* really good explanation ssh-agent https://smallstep.com/blog/ssh-agent-explained/   SSH Agent Explained

ssh-agent is a key manager for SSH. It holds your keys and certificates in memory, unencrypted, and ready for use by ssh. It saves you from typing a passphrase every time you connect to a server. 
It doesn't write any key material to disk. 
It doesn't allow your private keys to be exported.

running ssh-agent

```
ssh-agent 
SSH_AUTH_SOCK=/tmp/ssh-XXXXXXAGCnlO/agent.117; export SSH_AUTH_SOCK;
SSH_AGENT_PID=118; export SSH_AGENT_PID;
```

```
eval `ssh-agent -s`
```

or 

```
eval $(ssh-agent -s)

killall ssh-agent; eval "$(ssh-agent)"   or ssh-agent -k

```



https://aws.plainenglish.io/best-practices-for-ssh-key-management-in-ansible-from-lab-to-10-000-nodes-bcb50324b272


see https://stackoverflow.com/questions/57919339/how-to-run-ansible-playbook-using-a-public-ssh-key

running within semaphore account but using sudo/root allows ansible keys to be used from ansible account

cd /home/ansible/devel/gitrepos/COM614-cloud-computing/workup/aws-ansible-examples/ansible-semaphore-localstack-example/ansible/project-ansible3

sudo /opt/semaphore/apps/ansible/11.1.0/venv/bin/ansible  -i inventory.ini all -m ping


ansible-playbook -i inventory.ini roles/load-ssh-keys/main.yml
```


https://github.com/semaphoreui/semaphore/pull/1748


https://stackoverflow.com/questions/13033799/how-to-make-ssh-add-read-passphrase-from-a-file  red passphrase from file

```
#!/bin/bash

if [ $# -ne 2 ] ; then
  echo "Usage: ssh-add-pass keyfile passfile"
  exit 1
fi

eval $(ssh-agent)
pass=$(cat $2)

expect << EOF
  spawn ssh-add $1
  expect "Enter passphrase"
  send "$pass\r"
  expect eof
EOF

The usage is simply: ssh-add-pass keyfile passfile

https://docs.oracle.com/cd/E35328_01/E35336/html/vmcli-script.html

```
