# README


## Usage
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
to enable on startup boot
```
systemctl enable docker-compose@minion-remote-grpc-pi

```
you can review progress using

```
cd /opt/docker/compose/minion-remote-grpc-pi

docker compose logs -f minion-remote-pi-01

docker compose exec minion-remote-pi-01 bash

minion@minion-remote-pi-01:~$ ssh -p 8201 admin@localhost

admin@minion()> opennms:health-check                                                                                                     
Verifying the health of the container

Karaf extender                  [ Success  ] => 29 non-KAR features installed. 
Echo RPC (passive)              [ Success  ]
Verifying installed bundles     [ Success  ]
Connecting to gRPC IPC Server   [ Success  ]

=> Everything is awesome
```



## references

based on Docker compose as a systemd unit
https://gist.github.com/mosquito/b23e1c1e5723a7fd9e6568e5cf91180f

https://www.bluekeyboard.com/2024/06/19/setting-up-docker-compose-as-an-ubuntu-service-systemd/

https://bootvar.com/systemd-service-for-docker-compose/

https://opennms.discourse.group/t/karaf-cli-cheat-sheet/149

https://docs.opennms.com/horizon/33/deployment/minion/install.html