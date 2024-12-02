



Interfaces:

| interface | IP address  | Netmask       |Network     |
|:----------|:------------|:--------------|:-----------|
| eth0      |131.17.123.1 | 255.255.255.0 |131.17.123.0 |
| eth1      |131.17.78.1  | 255.255.255.0 |131.17.78.0 |
| eth2      |131.17.15.12 | 255.255.255.0 |131.17.15.0 |

Routing table:

| Network     | Netmask      | first hop |
|:------------|:-------------|:----------|
|131.175.21.0 |255.255.255.0 |131.17.123.254|
|131.175.16.0 |255.255.255.0 |131.17.78.254|
|131.56.0.0   |255.255.0.0   |131.17.15.254|
|131.155.0.0  |255.255.0.0   |131.17.15.254|
|0.0.0.0      |0.0.0.0       |131.17.123.254|

the following diagram shows how several routers form a network by routing between defined subnets.  

![alt text](../docs/images/routing.drawio.png "routing.drawio.png")


https://worldpopulationreview.com/country-rankings/ip-address-by-country


notes - google example https://www.lri.fr/~fmartignon/documenti/reseaux/3-RoutingForwarding-Martignon.pdf




# notes


physical layer - Mac addresses
IP layer - Ip addresses

TCP/UDP  ports
NAT

finding other devices on the netowrk -ARP

routing tables
routing protocols

DNS - translating IP addresses to

https://www.calculator.net/ip-subnet-calculator.html?cclass=any&csubnet=19&cip=10.79.128.1&ctype=ipv4&x=Calculate

on windows terminal try 

https://superuser.com/questions/29640/inverse-arp-lookup

https://www.networkworld.com/article/969445/checking-network-connections-with-arp-and-ip-neigh.html