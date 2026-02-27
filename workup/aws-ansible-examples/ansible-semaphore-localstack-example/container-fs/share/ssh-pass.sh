#!/bin/sh
echo "running_ssh-pass_pid_$$_$(date '+%F_%H:%M:%S')" >> /tmp/ssh-pass.log
if [ -f "/tmp/ansible_add_ssh_run_pid" ];
 then
  echo "exit - /tmp/ansible_add_ssh_run_pid already exists - ssh-add attempted second read of passphrase"  >> /tmp/ssh-pass.log
  rm /tmp/ansible_add_ssh_run_pid;
  exit 1;
 else
  echo "returning passphrase and creating /tmp/ansible_add_ssh_run_pid "  >> /tmp/ssh-pass.log
  echo "add-ssh_running_$(date '+%F_%H:%M:%S')" > /tmp/ansible_add_ssh_run_pid
fi
echo 'minad1234'
