# README

This is a minion which can run on a local pc and connect through a vpn

id: "minion-remote-pi-02"

location: "ftwidley2"

# notes

to set up a pi 5

the Pi will prefer to use the eth0 wired connection before using the wlan0 connection as its gateway.
In or experiments this might not be correct because we know that only the wired network has connectivity to the internet using eduroam.

On the pi we could correct this by deleting the etho default route using

```
sudo ip route del default dev eth0
```

or (newer pi)

```
sudo nmcli connection modify 'Wired connection 1' ipv4.route-metric 50
sudo nmcli connection up 'Wired connection 1' 

ip route 

```

# installation

To install eduroam on pi so automatically connects, use tethered hotspot (on phone) to download linux eduroam installer for your institution from https://cat.eduroam.org/

## install docker
install docker on pi  https://pimylifeup.com/raspberry-pi-docker/

```
sudo apt-get update
curl -sSL https://get.docker.com | sh
sudo usermod -aG docker $USER

sudo sudo systemctl enable docker

```

## install project

on pi

```
git clone https://github.com/gallenc/COM614-cloud-computing.git
cd COM614-cloud-computing/workup/production-radio/minion-remote-grpc-pi

```

set up docker compose service so pi restarts each time

```
sudo cp docker-compose@.service /etc/systemd/system/docker-compose@.service

sudo chmod 644 /etc/systemd/system/docker-compose@.service
```

Place the docker compose project in a folder named after the service.

e.g. place the project as a folder in `/opt/docker/compose/`

The project needs a docker-compose.yaml file in the project folder

```
/opt/docker/compose/minion-remote-grpc-pi
```

starting / stopping service

```
systemctl start docker-compose@minion-remote-grpc-pi

systemctl stop docker-compose@minion-remote-grpc-pi

```
to see logs for systemctl startup

```
journalctl -xeu docker-compose@minion-remote-grpc-pi.service

```

to enable on startup boot

```
systemctl enable docker-compose@minion-remote-grpc-pi

```
you can review progress using

```
cd /opt/docker/compose/minion-remote-grpc-pi

docker compose logs -f minion-remote-pi-01

docker compose exec minion-remote-pi-01 bash

(use exit to logout)

minion@minion-remote-pi-01:~$ ssh -p 8201 admin@localhost
Password authentication
(admin@localhost) Password:  (default admin)
(use logout to logout)

admin@minion()>bundle:list # will eventually show all OpenNMS bundles

note that startup takes several minutes - be patient

```
To check connectivity try

```
admin@minion()> opennms:health-check                                                                                                     
Verifying the health of the container

Karaf extender                  [ Success  ] => 29 non-KAR features installed. 
Echo RPC (passive)              [ Success  ]
Verifying installed bundles     [ Success  ]
Connecting to gRPC IPC Server   [ Success  ]

=> Everything is awesome
```

## setting up netsnmp on pi

this opens up all metrics to community string

(see https://bestmonitoringtools.com/raspberry-pi-snmp-monitoring-install-enable-agent-server/)

```
sudo apt update
sudo apt -y  install snmpd snmp

cp pisnmpd.conf /etc/snmp/snmpd.conf.d/

```

change listening address in /etc/snmp/snmpd.conf

```
#agentaddress  127.0.0.1,[::1]
agentaddress udp:161
```

also possible to respond only to particular addresses

```
agentAddress udp:161
...
# rocommunity public  default    -V systemonly
rocommunity public 172.25.7.169/32
```


start and enable  

```
sudo systemctl start snmpd
sudo systemctl enable snmpd
```

you can test using

```
snmpwalk -c piminion -v2c localhost 1.3.6

# to access docker host from inside docker container 
snmpwalk -c piminion -v2c 172.17.0.1      1.3.6

```


## references

based on Docker compose as a systemd unit
https://gist.github.com/mosquito/b23e1c1e5723a7fd9e6568e5cf91180f

https://www.bluekeyboard.com/2024/06/19/setting-up-docker-compose-as-an-ubuntu-service-systemd/

https://bootvar.com/systemd-service-for-docker-compose/

https://opennms.discourse.group/t/karaf-cli-cheat-sheet/149

https://docs.opennms.com/horizon/33/deployment/minion/install.html