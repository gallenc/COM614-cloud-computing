#!/bin/sh
echo "running ssh-pass  $(date '+%F_%H:%M:%S')" >> /tmp/ssh-pass.log
if ! [ -f "/tmp/ansible_add_ssh_run_pid" ]; then
   echo "returning passphrase and creating new /tmp/ansible_add_ssh_run_pid "  >> /tmp/ssh-pass.log
   echo "1 0" > /tmp/ansible_add_ssh_run_pid
fi
# read first line of file, check if a third variable ($stuff) is empty and both variables are numbers
read -r int_a int_b stuff < /tmp/ansible_add_ssh_run_pid
echo "reading /tmp/ansible_add_ssh_run_pid \$int_a=$int_a \$int_b=$int_b \$stuff = $stuff "  >> /tmp/ssh-pass.log
if [[ -z "$stuff" ]] && [[ $int_a =~ ^-?[0-9]+$ ]] && [[ $int_b =~ ^-?[0-9]+$ ]] ; then
   # check if second number is greater than or equal to first number, if so exit with error code 1, else update file with new numbers and return passphrase
   int_a=$((int_a+1))
   if [ $int_b -ge $int_a ]; then
     int_b=$int_a
     echo "$int_a $int_b" > /tmp/ansible_add_ssh_run_pid
     echo "exit - /tmp/ansible_add_ssh_run_pid \$int_a=$int_a \$int_b=$int_b ssh-add attempted multiple reads of passphrase"  >> /tmp/ssh-pass.log
     exit 1;
   else
     int_b=$((int_a+1))
     echo "ssh-add attempted first read of passphrase \$int_a=$int_a \$int_b=$int_b /tmp/ansible_add_ssh_run_pid "  >> /tmp/ssh-pass.log
     echo "$int_a  $int_b" > /tmp/ansible_add_ssh_run_pid
   fi;
else
   echo "pid file corrupted returning passphrase and creating new /tmp/ansible_add_ssh_run_pid "  >> /tmp/ssh-pass.log
   echo "1 0" > /tmp/ansible_add_ssh_run_pid
fi;
cat /run/secrets/ANSIBLE_SSH_PASSPHRASE
