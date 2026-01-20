# Vagrant Examples

## Installing Vagrant and VirtualBox

Vagrant is an open-source tool by HashiCorp that simplifies creating and managing portable, reproducible development environments using virtual machines (VMs). 
It is very similar in function to `docker compose`

I am using Vagrant for Windows with VirtualBox

VAgrant can work with other virtualisation platforms including Vmware, docker and KVM. 
However most of the documentation seems to prefer VirtualBox so this seems the most sensible choice. 

Vagrant can also be installed on Apple MAC and linux computers but I will leave that to your own research.

You can download Vagrant from [install vagrant](https://developer.hashicorp.com/vagrant/install)

Normally Vagrant stores downloaded `.box` files and other user configuration in your windows local settings e.g `C:\Users\YourUser\.vagrant.d\`

However this can mean that the boxes are stored on a one drive or other network drive, so I prefer to make sure they are stored on the local C drive. 
The location is set using the VAGRANT_HOME variable

```
setx VAGRANT_HOME C:\devel\vagrant\vagranthome
```
(setx a command-line tool to permanently create or modify user or system environment variables, writing them to the registry for future command prompt sessions)

You can download VirtualBox from [VirtualBox Downloads](https://www.virtualbox.org/wiki/Downloads)

Other virtual box installers and iso files are here (i amusing version 7.2.4) https://download.virtualbox.org/virtualbox/https://download.virtualbox.org/virtualbox/7.2.4/

Wen you install VirtualBox, I recommend that you also need to set the preferences to place the virtual machines in a location which is not on a network drive.

![alt text](../vagrant-examples/images/virtaulBoxPreferences.png "Figure virtaulBoxPreferences.png")


# Building your first machine

Vagrant is very easy to get started. 

Vagrant provide a number of pre-built `boxes` which are the starting point for creating a local machine.

See for instance [Alma Linux 10](alma linux  https://portal.cloud.hashicorp.com/vagrant/discover/almalinux/10)

Create a new empty folder and name it with no spaces .

Initialise a new vagrant project using

```
vagrant init almalinux/10 --box-version 10.1.20260110
```

This will create a .vagrant folder and a Vagrantfile in your folder

lookat vagrant up
vagrant box list

TBD

this example vagrant file does the networking in windows
see https://stackoverflow.com/questions/43203203/virtualbox-networking-using-vagrant

in powershell 




This example builds a box and then packages it as new master box which can be used for development

