#!/bin/bash

set -x

# script to set up new ansible user and generate and copy new ansible keys
# if environment variable ANSIBLE_SSH_PASSPHRASE is set, then used in generating the key

ANSIBLE_KEYS="/ssh-keys/.ssh-ansible"
ANSIBLE_USER_HOME="/home/ansible"
ANSIBLE_KEY_PASSPHRASE=""


# create ansible user (insecure password)
# The graphical login managers do not show users with UID below 1000
# only create ansible user if doesn't exist (note insecure password - replace with ssh key)
if getent passwd | grep -c '^ansible:' > /dev/null ;
  then 
    echo "ansible user already exists"; 
  else 
    echo creating ansible user; 
    sudo groupadd -f ansible
    sudo groupadd -f sudo   # ubuntu
    sudo groupadd -f wheel  # rhel
    sudo useradd -m -s /bin/bash  -u 800 --groups sudo,wheel  -g ansible --password "$(mkpasswd $ANSIBLE_ROOT_PASSWORD )"  ansible
    sudo echo "%ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible
fi

# only generate once but share among machines
if ! [ -d "$ANSIBLE_KEYS" ] ; 
  then
   echo creating ansible keys for stack in "$ANSIBLE_KEYS"
   sudo mkdir -p "$ANSIBLE_KEYS"
   
   if [ -v ANSIBLE_SSH_PASSPHRASE ];
     then
        ANSIBLE_KEY_PASSPHRASE=$ANSIBLE_SSH_PASSPHRASE 
        echo "using ansible keys with pass phrase" ;
        sudo ssh-keygen -t rsa -b 4096 -N "$ANSIBLE_KEY_PASSPHRASE" -f "$ANSIBLE_KEYS/id_rsa"
     else
        echo "using ansible keys with no pass phrase" ;
        sudo ssh-keygen -t rsa -b 4096 -N "" -f "$ANSIBLE_KEYS/id_rsa"
     fi

else
  echo repo "$ANSIBLE_KEYS" already exists so not regenerating
fi

# test if local machine already has keys
if  ! [ -d "$ANSIBLE_USER_HOME/.ssh" ]
 then
   echo copying ansible keys to "$ANSIBLE_USER_HOME/.ssh"
   sudo mkdir -p $ANSIBLE_USER_HOME/.ssh
   sudo chmod 700 $ANSIBLE_USER_HOME/.ssh

   sudo cp $ANSIBLE_KEYS/id_rsa $ANSIBLE_USER_HOME/.ssh
   
   sudo chmod 600 $ANSIBLE_USER_HOME/.ssh/id_rsa

   sudo cp $ANSIBLE_KEYS/id_rsa.pub $ANSIBLE_USER_HOME/.ssh/authorized_keys
   sudo chmod 644 $ANSIBLE_USER_HOME/.ssh/authorized_keys

   sudo cp $ANSIBLE_KEYS/id_rsa.pub $ANSIBLE_USER_HOME/.ssh
   sudo chmod 644 $ANSIBLE_USER_HOME/.ssh/id_rsa.pub

   sudo chown -R ansible:ansible $ANSIBLE_USER_HOME/.ssh
else
   echo repo "$ANSIBLE_USER_HOME/.ssh" already exists so not re-copying
fi
