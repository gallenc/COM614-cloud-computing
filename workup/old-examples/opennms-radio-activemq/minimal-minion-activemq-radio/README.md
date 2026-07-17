# RADIO CONFIG

This docker compose project contains configurations to test OpenNMS with simulated data (using snmpsim 0.4.x) for broadcast radio equipment.

docker-compose-external.yaml contains a configuration running a minion (minion1) which can connect to the VPN through the PC bridge.

```
docker compose -f docker-compose-external.yaml up -d
```

docker-compose.yaml contains the configuration running a minion (minion2) talking to a subnet containing 7 broadcast radio devices simulated using snmpsim.

The snmpsim containers all have netsnmp installed if you run a build (only once) before running the model

```
docker compose build
docker compose up -d
```

log into one of the snmpsim containers and run snmpwalk  as shown below.

Note that the community strings are public in the draytek routers.
This is achieved by mapping the drayteck snmpsim data files to public.snmpsim  in each container.

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

## Pris

Provisioning tool is available locally at

http://localhost:8000/

http://pris:8000/

requisition at http://localhost:8000/requisitions/testradiosite1

### Importing Requisition from PRIS


An event can be sent to OpenNMS to request that it imports a requisition from an external URL.

See [OpenNMS import provisioning to OpenNMS](https://docs.opennms.com/pris/2.0.0/provision-to-opennms.html)

[PRIS](https://docs.opennms.com/pris/2.0.0/index.html) is used as source of data to generate this requisition from an excel spreadsheet testradiosite1.csv.

A docker image for PRIS is used to run the PRIS service. 

You can see the requisiton by pointing a browser at http://localhost:8000/requisitions/testradiosite1  but within the docker network, the requisition is found at http://pris:8000/requisitions/testradiosite1

To tell OpenNMS to import PRIS use the following event (change address as necessary)

POST http://localhost:8980/opennms/rest/events

Content-Type Application/xml

Accept Application/xml

```
<event><uei>uei.opennms.org/internal/importer/reloadImport</uei>
     <parms><parm>
         <parmName>url</parmName><value>http://pris:8000/requisitions/testradiosite1</value>
     </parm></parms> 
</event>
```

## reloading using send event pl

```
docker compose exec horizon /usr/share/opennms/bin/send-event.pl uei.opennms.org/internal/importer/reloadImport -p 'url http://pris:8000/requisitions/testradiosite1' 
```

## rrd tool

https://oss.oetiker.ch/rrdtool/tut/cdeftutorial.en.html

## queries

```
-- SELECT id, node.nodeid, node.location, node.nodelabel, latitude, longitude FROM assets INNER JOIN node ON assets.nodeid = node.nodeid  WHERE latitude IS NOT NULL; 
--SELECT DISTINCT node.location, latitude, longitude FROM node

SELECT DISTINCT ON (node.location) node.location, latitude, longitude FROM assets INNER JOIN node ON assets.nodeid = node.nodeid  WHERE latitude IS NOT NULL; 
```

https://grafana.com/grafana/dashboards/5053-opennms-network-interfaces-report/

https://docs.opennms.com/helm/8/datasources/performance_datasource.html#filter-queries

https://docs.opennms.com/helm/8/panel_configuration/dynamic-dashboard.html#pc-template-filters

https://docs.opennms.com/helm/8/datasources/performance_datasource.html#filter-queries

https://docs.opennms.com/horizon/33/reference/configuration/filters/filters.html

https://grafana.com/docs/grafana/latest/panels-visualizations/visualizations/geomap/