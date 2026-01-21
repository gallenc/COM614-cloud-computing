#!/bin/bash

set -x

echo provisioning virtualbox guest additions after kernel update

# update and install VBoxGuestAdditions
echo installing VBoxGuestAdditions. This my take some time to complete. Ignore errors if no video drivers in image

# match the image version to your virtualbox version
# note you will need to restart your vm to use guest additions
wget -O ./VBoxGuestAdditions.iso https://download.virtualbox.org/virtualbox/7.2.4/VBoxGuestAdditions_7.2.4.iso

mkdir /media/VBoxGuestAdditions
mount -o loop,ro VBoxGuestAdditions.iso /media/VBoxGuestAdditions
sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
umount /media/VBoxGuestAdditions
rmdir /media/VBoxGuestAdditions
rm VBoxGuestAdditions.iso

echo finished installing VBoxGuestAdditions
