# opennms stack

OpenNMS stack to run with nginxproxy/nginx-proxy

to run with local nginx use 

using nginx variables so that nginx does not check availability of services before starting
see https://sandro-keil.de/blog/let-nginx-start-if-upstream-host-is-unavailable-or-down/

Note currently NGINX working for opennms not pgadmin or pris

```
docker compose  --profile local-nginx  up -d
```