# Setting up two virtual machines 

This configuration sets up two virtual machines based upon the [masterAlma10Box](../../example3/masterAlma10box)

Having configured the second ethnernet connection using

```
     alma_1.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--nic2", "hostonly"]
        vb.customize ["modifyvm", :id, "--hostonlyadapter2", "VirtualBox Host-Only Ethernet Adapter"] #use proper network name here
        vb.customize ["modifyvm", :id, "--cableconnected2", "on"]
     end
```

We need to change its configuration from DHCP to a static address using nmcli

```

     # set eth 1 to a static ip address below DHCP range of virtual box
     alma_1.vm.provision "shell", inline: <<-SHELL
       echo script setting static ip address 
       nmcli connection modify "Wired connection 2"  ipv4.method manual   ipv4.addresses 192.168.56.10/24
       nmcli connection down "Wired connection 2"
       nmcli connection up "Wired connection 2"
     SHELL
```

An extra script is injected into the machine which can be done to clone this repo in the machine to run as an example

The [additional-config.sh](../additional-config.sh) file should be run within the virtual machine using 

```
sh /vagrant/additional-config.sh
```

