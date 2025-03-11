# Production Configuration

This folder contains the production configurations for an opennms cloud service and for minions running on a raspberry pi

[minimal-minion-grpc-radio](../minimal-minion-grpc-radio)  docker compose project to run a full grafana, opennms, nginx, database and pgadmin4 in containers with example radio site configuration

https://ipaddress/opennms

https://ipaddress/grafana

https://ipaddress/pgadmin4

[minion-remote-grpc-PCdocker](../minion-remote-grpc-PCdocker)  docker compose project to run a minion on docker desktop behind a vpn to the site

[minion-remote-grpc-pi](../minion-remote-grpc-pi)  docker compose project to run a minion on a Raspberry pi on site

(See this project for running docker compose as a systemd service)
