
# DB7012 DAB receiver

https://www.devabroadcast.com/products/db7012

Professional DSP-based DAB/DAB+ Monitoring Receiver

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

###  notifTest

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

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.4  .1.3.6.1.4.1.35833.35.3.15.0 i 15104  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

###     notifRflvlWarningLow   (Warninglow threshold raise)

oid: .1.3.6.1.4.1.35833.35.254.0.5

varbind1 -  mntrRflvlValue .1.3.6.1.4.1.35833.35.3.15.0
           (mntr RFLvl Value -  Fr8p8 (Integer32) (0..17920))

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.5  .1.3.6.1.4.1.35833.35.3.15.0 i 15104  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

###     Name     notifRflvlWarningHigh   (WarningHigh threshold raise)

oid: .1.3.6.1.4.1.35833.35.254.0.6

varbind1 -  mntrRflvlValue .1.3.6.1.4.1.35833.35.3.15.0
           (mntr RFLvl Value -  Fr8p8 (Integer32) (0..17920))

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.6  .1.3.6.1.4.1.35833.35.3.15.0 i 15104  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

###     Name      notifDabLoss   (notifDabLoss raise)

oid: .1.3.6.1.4.1.35833.35.254.0.8

varbind1 -   mntrDab .1.3.6.1.4.1.35833.35.3.18.0
           ( INTEGER {sigDown(0),sigUp(1)})

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.8  .1.3.6.1.4.1.35833.35.3.15.0 i 15104  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

###     Name      notifDabOK   (notifDabOK clear)

oid: .1.3.6.1.4.1.35833.35.254.0.7

varbind1 -   mntrDab .1.3.6.1.4.1.35833.35.3.18.0
           ( INTEGER {sigDown(0),sigUp(1)})

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.7  .1.3.6.1.4.1.35833.35.3.15.0 i 15104  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

###     Name       notifSnrOk   (notifSnrOk clear)

oid: .1.3.6.1.4.1.35833.35.254.0.9

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.9  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

###     Name       notifSnrLow   (notifSnrLow raise)

oid: .1.3.6.1.4.1.35833.35.254.0.10

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.10  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```


###     Name        notifSnrHigh   ( notifSnrHigh raise)

oid: .1.3.6.1.4.1.35833.35.254.0.11

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.11  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```


###     Name         notifSnrWarningLow   (  notifSnrWarningLow raise)

oid: .1.3.6.1.4.1.35833.35.254.0.12

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.12  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```


###     Name    notifSnrWarningHigh   (   notifSnrWarningHigh raise)

oid: .1.3.6.1.4.1.35833.35.254.0.13

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.13  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```


###     Name  notifCnrOk   (  notifCnrOk clear)

oid: .1.3.6.1.4.1.35833.35.254.0.14

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.14  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

###     Name   notifCnrLow   (  notifCnrLow raise)

oid: .1.3.6.1.4.1.35833.35.254.0.15

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.15  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```


###     Name    notifCnrHigh   (  notifCnrHigh raise)

oid: .1.3.6.1.4.1.35833.35.254.0.16

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.16  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

###     Name     notifCnrWarningLow   (  notifCnrWarningLow raise)

oid: .1.3.6.1.4.1.35833.35.254.0.17

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.17  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

###     Name     notifCnrWarningHigh   (  notifCnrWarningHigh raise)

oid: .1.3.6.1.4.1.35833.35.254.0.18

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.18  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

###     Name  notifLeftOk   (  notifLeftOk raise)

oid: .1.3.6.1.4.1.35833.35.254.0.19

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.19  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

###     Name  notifLeftLow   ( notifLeftLow raise)

oid: .1.3.6.1.4.1.35833.35.254.0.20

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.20  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```


###     Name  notifLeftHigh   (  notifLeftHigh raise)

oid: .1.3.6.1.4.1.35833.35.254.0.21

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.21  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```


###     Name   notifLeftWarningLow   (  notifLeftWarningLow raise)

oid: .1.3.6.1.4.1.35833.35.254.0.22

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.22  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

###     Name     notifRightOk   ( notifRightOk clear)

oid: .1.3.6.1.4.1.35833.35.254.0.24

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.24  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

###     Name    notifRightLow  (  notifRightLow raise)

oid: .1.3.6.1.4.1.35833.35.254.0.25

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.25  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```


###     Name   notifRightHigh  (  notifRightHigh raise)

oid: .1.3.6.1.4.1.35833.35.254.0.26

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.26  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

###     Name   notifRightWarningLow (  notifRightWarningLow raise)

oid: .1.3.6.1.4.1.35833.35.254.0.27

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.27  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```


###     Name   notifRightWarningHigh (  notifRightWarningHigh raise)

oid: .1.3.6.1.4.1.35833.35.254.0.28

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.28  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```


###     Name    notifFicQualityOk (  notifFicQualityOk clear)

oid: .1.3.6.1.4.1.35833.35.254.0.29

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.29  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```


###     Name     notifFicQualityLow (  notifFicQualityLow raise)

oid: .1.3.6.1.4.1.35833.35.254.0.30

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.30  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

###     Name   notifFicQualityHigh (   notifFicQualityHigh raise)

oid: .1.3.6.1.4.1.35833.35.254.0.31

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.31  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

###     Name   notifFicQualityWarningLow (  notifFicQualityWarningLow raise)

oid: .1.3.6.1.4.1.35833.35.254.0.32

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.32  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```

###     Name    notifFicQualityWarningHigh ( notifFicQualityWarningHigh raise)

oid: .1.3.6.1.4.1.35833.35.254.0.33

varbind1 -   mntrSnrValue .1.3.6.1.4.1.35833.35.3.19.0
           ( Fr8p8 (Integer32) (0..5120) )

varbind2 - alias .1.3.6.1.4.1.35833.35.2.7.1.0
           (alias name for the device - display string)

varbind3 - snmpaid .1.3.6.1.4.1.35833.35.2.2.3.4.0 
           (SNMP agent id for device ) 


```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.35.254.0.33  .1.3.6.1.4.1.35833.35.3.19.0 i 3840  .1.3.6.1.4.1.35833.35.2.7.1.0 s 'Angel DAB RX'  .1.3.6.1.4.1.35833.35.2.2.3.4.0  i 0

```
