

## DB7012 SNMP Walk

```
 snmpwalk -v1 -On 192.168.105.101 -c DEVA7012 .1.3
```

## SNMPSIM recording

```
 snmprec.py --community=DEVA7012  --protocol-version=1   --agent-udpv4-endpoint=192.168.105.101 --output-file=./DEVA7012.snmprec
```

## MIB parsing

mib file DB7012-MIB.mib has been corrected so that it compiles DB7012-MIB-corrected.mib


## DB7012 Test Events (netsnmp)

### notif test

oid: .1.3.6.1.4.1.35833.35.254.0.1

varbind1 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind2 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 

(not clear what this trap is for)

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.1   .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```


###  notifRflvlOk   (clear)

oid: .1.3.6.1.4.1.35833.35.254.0.2

varbind1 -  mntrRflvlValue .1.3.6.1.4.1.35833.35.3.15.0
           (mntr RFLvl Value -  Fr8p8 (Integer32) (0..17920))

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.2  .1.3.6.1.4.1.35833.35.3.15.0 i 15104  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

###   notifRflvlLow   (low threshold raise)

oid: .1.3.6.1.4.1.35833.35.254.0.3

varbind1 -  mntrRflvlValue .1.3.6.1.4.1.35833.35.3.15.0
           (mntr RFLvl Value -  Fr8p8 (Integer32) (0..17920))

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.3  .1.3.6.1.4.1.35833.35.3.15.0 i 15104  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

###    notifRflvlHigh   (hi threshold raise)

oid: .1.3.6.1.4.1.35833.35.254.0.4

varbind1 -  mntrRflvlValue .1.3.6.1.4.1.35833.35.3.15.0
           (mntr RFLvl Value -  Fr8p8 (Integer32) (0..17920))

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 

(not clear what this trap is for)

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.4  .1.3.6.1.4.1.35833.35.3.15.0 i 15104  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

