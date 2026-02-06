# example docker compose service

The intention is that the containers are run as a docker compose service which starts when the machine starts up under `systemd` i.e.  `systemctl start SERVICENAME.service`

The docker compose service is defined in wordpress-stack  this is a standard wordpress behind an nginx load balancer.

You will need to find the address of the machine running the stack using `ifconfig`. 

You can browse to that machine using http://<address>

## linking to the repository

We want to check out the project master github repository but this contains many configuration examples, so we use a `simlink` to choose which configurations are relevant

The `git-docker-ansible-config.sh` script runs as user `ansible` and

1. checks out the repository to the `/home/ansible/devel/gitrepos/`  folder 

2. creates a simlink from `/opt/docker/compose/docker-compose-services` to the folders containing the docker compose services on the machine

```
mkdir -p /opt/docker/compose

# use this if you only want to create a link
ln -s /home/ansible/devel/gitrepos/COM614-cloud-computing/sessions/session2/ansible-examples/docker-compose-services /opt/docker/compose/docker-compose-services

# or use this option to create a new link or replace the old link with a new one
sudo ln -sf /opt/docker/compose/docker-compose-services /home/ansible/devel/gitrepos/COM614-cloud-computing/sessions/session2/ansible-examples/docker-compose-services

```
Once the link is created, you should be able to run docker compose commands from the `/opt/docker/compose/docker-compose-services/` folder

```
docker compose -f /opt/docker/compose/docker-compose-services/wordpress-stack/docker-compose.yaml down
 
docker compose -f //opt/docker/compose/docker-compose-services/wordpress-stack/docker-compose.yaml up -d

docker compose -f /opt/docker/compose/docker-compose-services/wordpress-stack/docker-compose.yaml ps
 
```

## set up a docker-compose systemd service

```
sudo cp docker-compose@.service /etc/systemd/system/docker-compose@.service

sudo chmod 644 /etc/systemd/system/docker-compose@.service
```

Place the docker compose project in a folder named after the service.

e.g. place the project as a folder in `/opt/docker/compose/docker-compose-services`

The project needs to have a docker-compose.yaml file in the project folder

```
/opt/docker/compose/docker-compose-services/wordpress-stack
```

starting / stopping service

```
sudo systemctl start docker-compose@wordpress-stack

sudo systemctl stop docker-compose@wordpress-stack

```
to see logs for systemctl startup

```
sudo journalctl -xeu docker-compose@wordpress-stack.service

```

Note - we may want to be cleverer with this because systemctl currently waits while any download is happening 

#  set docker compose restarts every time the system restarts

to enable on startup boot

```
systemctl enable docker-compose@wordpress-stack

