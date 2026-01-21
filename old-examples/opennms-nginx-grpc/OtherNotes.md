# nginx grpc

https://www.nginx.com/blog/nginx-1-13-10-grpc/


# debugging

to debug an opennms docker container use the following comand

```
environment:
      TZ: ${TIMEZONE:-America/New_York}
      # JAVA_OPTS matches default in container plus enable debugger
      JAVA_OPTS: -Xmx1024m -XX:MaxMetaspaceSize=512m -agentlib:jdwp=transport=dt_socket,server=y,address=*:8001,suspend=n
      
     
ports:
  ...
  - "8001:8001" # JPDA debugging port
```

to access from windows

```
jdb -connect com.sun.jdi.SocketAttach:hostname=localhost,port=8001
```

note
https://pages.cs.wisc.edu/~horwitz/jdb/jdb.html  JDB Quick Reference Guide

```
jdb -attach localhost:8000
(for un*x/linux) or

jdb -connect com.sun.jdi.SocketAttach:hostname=localhost,port=8000
(for Windows). A successful connection is indicated by

Set uncaught java.lang.Throwable
Set deferred uncaught java.lang.Throwable
Initializing jdb ...
The error java.io.IOException: shmemBase_attach failed: The system cannot find the file specified will occur if you are on Windows and try to use jdb -attach localhost:8000; this will try to use shmem by default instead of sockets. 
```

to get into opennms karaf
```
ssh -p 8101 admin@localhost
```

karaf cli cheatsheet https://opennms.discourse.group/t/karaf-cli-cheat-sheet/149

opennms:collect org.opennms.netmgt.collectd.HttpCollector nginx collection=nginx_stats port=80

https://www.freeformatter.com/java-regex-tester.html#before-output
