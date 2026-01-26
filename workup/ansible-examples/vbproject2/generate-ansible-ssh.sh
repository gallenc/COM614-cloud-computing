#!/bin/bash

set -x

# script to generate and copy new ansible keys

ANSIBLE_KEYS="/vagrant/.ssh-ansible"
ANSIBLE_USER_HOME="/home/ansible"

# only generate once but share among machines
if ! [ -d "$ANSIBLE_KEYS" ]; then
   echo creating ansible keys for stack in "$ANSIBLE_KEYS"
   mkdir -p "$ANSIBLE_KEYS"
   ssh-keygen -t rsa -b 4096 -N "" -f "$ANSIBLE_KEYS/id_rsa"
else
   echo repo "$ANSIBLE_KEYS" already exists so not regenerating
fi

# test if local machine already has keys
if sudo bash -c ' ! [ -d "$ANSIBLE_USER_HOME/.ssh" ]' 
 then
   echo copying ansible keys to "$ANSIBLE_USER_HOME/.ssh"
   sudo mkdir -p $ANSIBLE_USER_HOME/.ssh
   sudo chmod 700 $ANSIBLE_USER_HOME/.ssh

   sudo cp .ssh-ansible/id_rsa $ANSIBLE_USER_HOME/.ssh
   
   sudo chmod 600 $ANSIBLE_USER_HOME/.ssh/id_rsa

   sudo cp .ssh-ansible/id_rsa.pub $ANSIBLE_USER_HOME/.ssh/authorized_keys
   sudo chmod 644 $ANSIBLE_USER_HOME/.ssh/authorized_keys

   sudo cp .ssh-ansible/id_rsa.pub $ANSIBLE_USER_HOME/.ssh
   sudo chmod 644 $ANSIBLE_USER_HOME/.ssh/id_rsa.pub

   sudo chown -R ansible:ansible $ANSIBLE_USER_HOME/.ssh
else
   echo repo "$ANSIBLE_USER_HOME/.ssh" already exists so not re-copying
fi