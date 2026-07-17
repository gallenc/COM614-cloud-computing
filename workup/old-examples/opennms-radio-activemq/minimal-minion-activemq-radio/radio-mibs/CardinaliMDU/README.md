# Cardinal iMDU (Mains Distribution Unit)

## SNMP Walk

```
snmpwalk -v1 -On 192.168.105.250 -c public .1.3
```

## SNMPSIM recording

```
snmprec.py --community=public  --protocol-version=1   --agent-udpv4-endpoint=192.168.105.250 --output-file=./cardinalImdu.snmprec

```

# MIB files

Note that the original file supplied by the manufacturer (Cardinal-MIB 2008141557Z2.mib) has been corrected to allow it to compile (Cardinal-MIB 2008141557Z2-corrected.mib)


## CardinalMDU Test Events (netsnmp)

Note that events arc defiend as SNMP v1 and SNMP v2

this is only trap that makes sense as an alarm

###   outputFuseChangeNotification V2 clear

oid: .1.3.6.1.4.1.8890.2.2002.3.2

varbind1 - outputName .1.3.6.1.4.1.8890.2.2002.1.4.1.1.2
           (  OutputName (OCTET STRING) (SIZE(1..8)). Hint: 8a A label assigned to this output to allow it to be easily identified. Upto 8 characters long.)

varbind2 - fuseState .1.3.6.1.4.1.8890.2.2002.1.3.1.1.4 
           ( FuseStates (Integer32) {ok(0), fail(1) }. Hint: d) 

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.8890.2.2002.3.2   .1.3.6.1.4.1.8890.2.2002.1.4.1.1.2 s 'Fuse 1'  .1.3.6.1.4.1.8890.2.2002.1.3.1.1.4  i 0

```
###   outputFuseChangeNotification V2 raise

oid: .1.3.6.1.4.1.8890.2.2002.3.2

varbind1 - outputName .1.3.6.1.4.1.8890.2.2002.1.4.1.1.2
           (  OutputName (OCTET STRING) (SIZE(1..8)). Hint: 8a A label assigned to this output to allow it to be easily identified. Upto 8 characters long.)

varbind2 - fuseState .1.3.6.1.4.1.8890.2.2002.1.3.1.1.4 
           ( FuseStates (Integer32) {ok(0), fail(1) }. Hint: d) 

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.8890.2.2002.3.2   .1.3.6.1.4.1.8890.2.2002.1.4.1.1.2 s 'Fuse 1'  .1.3.6.1.4.1.8890.2.2002.1.3.1.1.4  i 1

```

###   outputFuseChangeNotification V1 clear

oid: .1.3.6.1.4.1.8890.2.2002.2.0.2

varbind1 - outputName .1.3.6.1.4.1.8890.2.2002.1.4.1.1.2
           (  OutputName (OCTET STRING) (SIZE(1..8)). Hint: 8a A label assigned to this output to allow it to be easily identified. Upto 8 characters long.)

varbind2 - fuseState .1.3.6.1.4.1.8890.2.2002.1.3.1.1.4 
           ( FuseStates (Integer32) {ok(0), fail(1) }. Hint: d) 

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.8890.2.2002.3.2   .1.3.6.1.4.1.8890.2.2002.1.4.1.1.2 s 'Fuse 1'  .1.3.6.1.4.1.8890.2.2002.1.3.1.1.4  i 0

```
###   outputFuseChangeNotification V1 raise

oid: .1.3.6.1.4.1.8890.2.2002.2.0.2

varbind1 - outputName .1.3.6.1.4.1.8890.2.2002.1.4.1.1.2
           (  OutputName (OCTET STRING) (SIZE(1..8)). Hint: 8a A label assigned to this output to allow it to be easily identified. Upto 8 characters long.)

varbind2 - fuseState .1.3.6.1.4.1.8890.2.2002.1.3.1.1.4 
           ( FuseStates (Integer32) {ok(0), fail(1) }. Hint: d) 

```
snmptrap -v 2c -c public horizon:1162 ""  .1.3.6.1.4.1.8890.2.2002.3.2   .1.3.6.1.4.1.8890.2.2002.1.4.1.1.2 s 'Fuse 1'  .1.3.6.1.4.1.8890.2.2002.1.3.1.1.4  i 1

```