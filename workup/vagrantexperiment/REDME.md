# installing vagrant on rockylinux9 on ipmi servers

based on https://oneuptime.com/blog/post/2026-03-02-how-to-set-up-vagrant-with-kvm-provider-on-ubuntu/view

additional commands to set up bridge to eth1 interface

```
ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp1s0f0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
    link/ether 00:25:90:3d:0f:ba brd ff:ff:ff:ff:ff:ff
3: enp1s0f1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 00:25:90:3d:0f:bb brd ff:ff:ff:ff:ff:ff
4: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default 
link/ether 02:24:1b:f0:8e:c9 brd ff:ff:ff:ff:ff:ff

sudo nmcli connection add type bridge con-name br1 ifname br1
 sudo nmcli connection add type bridge-slave con-name br1-slave ifname enp1s0f0 master br1
sudo nmcli connection up br1
sudo nano /etc/qemu-kvm/bridge.conf
#add line 
allow br1
 
sudo systemctl restart libvirtd

```
