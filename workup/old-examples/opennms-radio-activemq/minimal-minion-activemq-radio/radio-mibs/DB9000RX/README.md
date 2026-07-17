# DB9000-RX 

Professional IP Audio Decoder https://www.devabroadcast.com/db9000-rx

The DB9000-RX is a reliable IP to Audio decoder, designed to support HE-AAC and MPEG-1 Layer 3 compressed audio streams and PCM uncompressed stream for audio transmission without quality loss.


## SNMP WALK DB9000RX

```
snmpwalk -v1 -On 192.168.105.99 -c DEVA9000 .1.3
```


## SNMPSIM recording

```
 snmprec.py --community=DEVA9000  --protocol-version=1   --agent-udpv4-endpoint=192.168.105.99 --output-file=./DEVA9000.snmprec
```


## DB9000RX Test Events (netsnmp)

### alarmTest

oid: .1.3.6.1.4.1.35833.7.4.1

varbind1 - snmpAgentID .1.3.6.1.4.1.35833.7.2.4.4.0

varbind2 - serial .1.3.6.1.4.1.35833.7.1.2.0   
           (Device Serial Number octet string)

(not clear what this trap is for)

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.7.2.4.4.0   .1.3.6.1.4.1.35833.7.2.4.4.0 i 0  .1.3.6.1.4.1.35833.7.1.2.0 s 9KRJ335C

```

#### alarmInputSwitch

oid: .1.3.6.1.4.1.35833.7.4.2

varbind1 - snmpAgentID .1.3.6.1.4.1.35833.7.2.4.4.0

varbind2 - currentSource .1.3.6.1.4.1.35833.7.3.1.0

current source values  INTEGER { url1(0) ,url2(1), url3(2), mp3player(3) , icecastClient(4), rtpClient(5)}

#### change to url1

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.7.4.2   .1.3.6.1.4.1.35833.7.2.4.4.0 i 0  .1.3.6.1.4.1.35833.7.3.1.0 i 0

```

#### change to url2

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.7.4.2   .1.3.6.1.4.1.35833.7.2.4.4.0 i 0  .1.3.6.1.4.1.35833.7.3.1.0 i 1

```


#### change to url3

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.7.4.2   .1.3.6.1.4.1.35833.7.2.4.4.0 i 0  .1.3.6.1.4.1.35833.7.3.1.0 i 2
```

#### change to mp3player

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.7.4.2   .1.3.6.1.4.1.35833.7.2.4.4.0 i 0  .1.3.6.1.4.1.35833.7.3.1.0 i 3
```

#### change to icecastClient

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.7.4.2   .1.3.6.1.4.1.35833.7.2.4.4.0 i 0  .1.3.6.1.4.1.35833.7.3.1.0 i 4
```

#### change to rtpClient(5)

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.35833.7.4.2   .1.3.6.1.4.1.35833.7.2.4.4.0 i 0  .1.3.6.1.4.1.35833.7.3.1.0 i 5
```

