# Deva Silence Switcher  DB8008

https://www.deva-broadcast-tools.com/products/db8008

## SNMP WALK

```
snmpwalk -v1 -On 192.168.105.100 -c DEVA8008 .1.3
```


## SNMPSIM recording

```
 snmprec.py --community=DEVA8008  --protocol-version=1   --agent-udpv4-endpoint=192.168.105.100 --output-file=./DEVA8008.snmprec
```

## DB8008 Test Events (netsnmp)

### notif test

oid: .1.3.6.1.4.1.35833.6.254.0.1

varbind1 - alias .1.3.6.1.4.1.35833.6.2.8.1.0
           (alias name for the device - display string)

varbind2 - snmpaid .1.3.6.1.4.1.35833.6.2.7.3.5.0  
           (SNMP agent id for device )

(not clear what this trap is for)

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.6.254.0.1   .1.3.6.1.4.1.35833.6.2.8.1.0 s 'Angel audio switch 98.6'  .1.3.6.1.4.1.35833.7.1.2.0 i 0

```

### notify source changed

oid: .1.3.6.1.4.1.35833.6.254.0.2


varbind1 - mntrSource .1.3.6.1.4.1.35833.6.3.1.0

        ( monitor source INTEGER {insel2MainAudio(1),insel2AUXAudio(2),insel2IPAudioClient1(3),insel2IPAudioClient2(4),insel2IPAudioClient3(5),insel2RTPReceiver(6),insel2MP3Player(7),insel2MainAnalog(13),insel2MainDigital(14),insel2AUXAnalog(15),insel2AUXDigital(16),insel2Auto(128))

varbind2 - mntrSourceAppliedby .1.3.6.1.4.1.35833.6.3.2.0 

         (monitor source applied by  INTEGER {appliedAutoselected(0),appliedForcedOverWEB(1),appliedForcedByDaypart(2),appliedForcedOverSNMP(3),appliedForcedByGPI(4)} )

varbind3 - alias .1.3.6.1.4.1.35833.6.2.8.1.0
           (alias name for the device - display string)

varbind4 - snmpaid .1.3.6.1.4.1.35833.6.2.7.3.5.0  
           (SNMP agent id for device )

         
#### example source changed to insel2MainAudio

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.6.254.0.2  .1.3.6.1.4.1.35833.6.3.2.0 i 1  .1.3.6.1.4.1.35833.6.3.2.0 i 0 .1.3.6.1.4.1.35833.6.2.8.1.0 s 'Angel audio switch 98.6'  .1.3.6.1.4.1.35833.7.1.2.0 i 0

```

#### example source changed to insel2AUXAudio

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.6.254.0.2  .1.3.6.1.4.1.35833.6.3.2.0 i 2  .1.3.6.1.4.1.35833.6.3.2.0 i 0 .1.3.6.1.4.1.35833.6.2.8.1.0 s 'Angel audio switch 98.6'  .1.3.6.1.4.1.35833.7.1.2.0 i 0

```


### notify digitalsync loss

oid: .1.3.6.1.4.1.35833.6.254.0.3


varbind1 - mntrSource .1.3.6.1.4.1.35833.6.3.1.0

        ( monitor source INTEGER {insel2MainAudio(1),insel2AUXAudio(2),insel2IPAudioClient1(3),insel2IPAudioClient2(4),insel2IPAudioClient3(5),insel2RTPReceiver(6),insel2MP3Player(7),insel2MainAnalog(13),insel2MainDigital(14),insel2AUXAnalog(15),insel2AUXDigital(16),insel2Auto(128))

varbind3 - alias .1.3.6.1.4.1.35833.6.2.8.1.0
           (alias name for the device - display string)

varbind4 - snmpaid .1.3.6.1.4.1.35833.6.2.7.3.5.0  
           (SNMP agent id for device )
           
### notify digitalsync recover

oid: .1.3.6.1.4.1.35833.6.254.0.43

varbind1 - mntrSource .1.3.6.1.4.1.35833.6.3.1.0

        ( monitor source INTEGER {insel2MainAudio(1),insel2AUXAudio(2),insel2IPAudioClient1(3),insel2IPAudioClient2(4),insel2IPAudioClient3(5),insel2RTPReceiver(6),insel2MP3Player(7),insel2MainAnalog(13),insel2MainDigital(14),insel2AUXAnalog(15),insel2AUXDigital(16),insel2Auto(128))

varbind3 - alias .1.3.6.1.4.1.35833.6.2.8.1.0
           (alias name for the device - display string)

varbind4 - snmpaid .1.3.6.1.4.1.35833.6.2.7.3.5.0  
           (SNMP agent id for device )


#### example digital sync loss insel2MainAudio (change the mntrSource for other alarm raises)

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.6.254.0.3   .1.3.6.1.4.1.35833.6.3.1.0 i 1 .1.3.6.1.4.1.35833.6.2.8.1.0 s 'Angel audio switch 98.6'  .1.3.6.1.4.1.35833.7.1.2.0 i 0

```

#### example digital sync recover insel2MainAudio  (change the mntrSource for other clears)

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.6.254.0.43   .1.3.6.1.4.1.35833.6.3.1.0 i 1 .1.3.6.1.4.1.35833.6.2.8.1.0 s 'Angel audio switch 98.6'  .1.3.6.1.4.1.35833.7.1.2.0 i 0

```


### notify audio loss

oid: .1.3.6.1.4.1.35833.6.254.0.5


varbind1 - mntrSource .1.3.6.1.4.1.35833.6.3.1.0

        ( monitor source INTEGER {insel2MainAudio(1),insel2AUXAudio(2),insel2IPAudioClient1(3),insel2IPAudioClient2(4),insel2IPAudioClient3(5),insel2RTPReceiver(6),insel2MP3Player(7),insel2MainAnalog(13),insel2MainDigital(14),insel2AUXAnalog(15),insel2AUXDigital(16),insel2Auto(128))

varbind3 - alias .1.3.6.1.4.1.35833.6.2.8.1.0
           (alias name for the device - display string)

varbind4 - snmpaid .1.3.6.1.4.1.35833.6.2.7.3.5.0  
           (SNMP agent id for device )
           
### notify audio recover

oid: .1.3.6.1.4.1.35833.6.254.0.6

varbind1 - mntrSource .1.3.6.1.4.1.35833.6.3.1.0

        ( monitor source INTEGER {insel2MainAudio(1),insel2AUXAudio(2),insel2IPAudioClient1(3),insel2IPAudioClient2(4),insel2IPAudioClient3(5),insel2RTPReceiver(6),insel2MP3Player(7),insel2MainAnalog(13),insel2MainDigital(14),insel2AUXAnalog(15),insel2AUXDigital(16),insel2Auto(128))

varbind3 - alias .1.3.6.1.4.1.35833.6.2.8.1.0
           (alias name for the device - display string)

varbind4 - snmpaid .1.3.6.1.4.1.35833.6.2.7.3.5.0  
           (SNMP agent id for device )

#### example  audio loss insel2MainAudio (change the mntrSource for other alarm raises)

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.6.254.0.5   .1.3.6.1.4.1.35833.6.3.1.0 i 1 .1.3.6.1.4.1.35833.6.2.8.1.0 s 'Angel audio switch 98.6'  .1.3.6.1.4.1.35833.7.1.2.0 i 0

```

#### example  audio recover insel2MainAudio  (change the mntrSource for other clears)

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.6.254.0.6   .1.3.6.1.4.1.35833.6.3.1.0 i 1 .1.3.6.1.4.1.35833.6.2.8.1.0 s 'Angel audio switch 98.6'  .1.3.6.1.4.1.35833.7.1.2.0 i 0

```
