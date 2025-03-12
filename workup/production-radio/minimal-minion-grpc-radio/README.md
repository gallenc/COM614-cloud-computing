# RADIO CONFIG


This docker compose project contains configurations to test OpenNMS with simulated data (using snmpsim 0.4.x) for broadcast radio equipment.

## connecting to vpn

Two docker compose files are provided. 

docker-compose-external.yaml contains a configuration running a minion (minion1) which can connect to the external VPN through the PC bridge.

```
docker compose -f docker-compose-external.yaml up -d
```

## nginx proxy for UIs

NGINX is installed as a self certificate https proxy.
 
The following services are available when the project is running

https://localhost/opennms  username opennms password opennms

https://localhost/grafana  username admin password mypass

https://localhost/pgadmin4 username user-name@domain-name.com password minad1234

pgadmin4 is a tool for accessing the database directly using SQL

## simulation

docker-compose.yaml contains the configuration running a minion (minion2) talking to a subnet containing 7 broadcast radio devices simulated using snmpsim. 

Note that because these devices are on the same IP subnet as the VPN, docker desktop will not allow this simulation network to work at the same time as the direct connection through the VPN. (hence the separate docker-compose-external.yaml) 

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


## rrd tool

https://oss.oetiker.ch/rrdtool/tut/cdeftutorial.en.html


## standby router service poller 

the SNMP monitor https://docs.opennms.com/horizon/33/reference/service-assurance/monitors/SnmpMonitor.html

  is used to check if the virtual router 192.168.105.245 is primary or secondary.
If it is not primary, then a service alarm is raised.

The poller-configuration.xml file contains the configuration which checks the snmp router name which is currently the primary router

```
      <!-- checks viror virtual router router is running on primary router-->
      <service name="VIGOR2927L-VIRTUAL" interval="300000" user-defined="false" status="on">
         <parameter key="oid" value=".1.3.6.1.2.1.1.5.0 "/>
         <parameter key="operator" value="="/>
         <parameter key="operand" value="${requisition:primarysnmproutername|not set}"/>
         <parameter key="reason-template" value="Virtual Router Service is running on standby router. The state should be ok (${operand}) the observed value is (${observedValue})"/> 
      </service>
```

Which checks if the router name on the virtual router matches the `primarysnmproutername` metadata in the requisition definition

```
   <node location="ftwidley1" foreign-id="FTWIDLEY1-VIGOR2927L-VIRTUAL" node-label="FTWIDLEY1-VIGOR2927L-VIRTUAL">
      <interface ip-addr="192.168.105.254" status="1" snmp-primary="P">
         <monitored-service service-name="ICMP"/>
         <monitored-service service-name="SNMP"/>
         <monitored-service service-name="VIGOR2927L-VIRTUAL"/>
      </interface>
      <meta-data context="requisition" key="primarysnmproutername" value="Widley_Pri"/>
   </node>
```