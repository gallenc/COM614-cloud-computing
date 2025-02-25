# RADIO CONFIG

snmpsim containers all have netsnmp installed if you run a build (only once) before running model

```
docker compose build
docker compose up -d
```

log into a snmpsim container and run snmpwalk

Note that the community strings are public in the draytek routers.
This is achieved by mapping the data files in each container.

```
docker compose exec DB9000RX bash
```

|service name   |ip address |read community |
|---------------|--------------|--------------|
|VIGOR2927L-SEC |192.168.105.2 | public  |
|DB8008         |192.168.105.100 |DEVA8008|
|VIGOR2927L-VIRTUAL |192.168.105.254|public  |
|VIGOR2927-PRI  |192.168.105.10|public  |
|DB7012         |192.168.105.101|DEVA7012 |
|DB9000RX       |192.168.105.99| DEVA9000 |
|cardinalImdu   |192.168.105.250 |public  |
|snmpsim        |172.20.0.100|(see config for community strings )  |

```
snmpwalk -v1 -On DB7012 -c DEVA7012 .1.3
```

```
snmpwalk -v1 -On DB8008 -c DEVA8008 .1.3
```

```
snmpwalk -v1 -On DB9000RX -c DEVA9000 .1.3
```

```
snmpwalk -v1 -On VIGOR2927-PRI -c public .1.3
```

```
snmpwalk -v1 -On VIGOR2927L-SEC -c public .1.3
```

```
snmpwalk -v1 -On VIGOR2927L-VIRTUAL -c public .1.3
```

```
snmpwalk -v1 -On cardinalImdu -c public .1.3
```