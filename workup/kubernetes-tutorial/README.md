# Kubernetes tutorial

notes based on [Techworld with Nana Kubernetes Tutorial for Beginners FULL COURSE in 4 Hours](https://www.youtube.com/watch?v=X48VuDVv0do)

## What is Kubernetes

* open source container orchestration framework - google
* monolyth to microservices - independent applications with thousands of containers
* need proper way to manage containers for high availability, scalability, disaster recovery

## components of Kubernetes

* node (or worker node)  - VM or physical node running kubernetes containers

* pod - abstraction of container - allows container technologies to change
* usually one application per pod
* each pod gets own IP address - new each restart
* pods are ephemeral - no state


* service - permanent ip address attached to the pod even if the pod dies 
* external service / internal services accessed using IP Address of the NODE and a port number (http://myapp.com (not https etc))

* Ingress - request to ingress which forwards to service

* configMap - properties config map connected to a POD

* secret - secret stored in base 64 encoded format ( passwords certs etc in secret) connected to pod

* volumes - attaches physical storage to the pod - remote or internal to node - storage is separate to the cluster. Kubernetes does not ake care of persistance.

* deployment - determines the number of pod replicas which are part of a service. service is a load balancer which sends requests to pods in deployment

* stateful set - used to replicate data for statefull services such as databases. Deploying databases using stateful sets is tedious - typically we have an external database 


## Kuberentes architecture

* kubernetes cluster - master and server nodes (3 processes on every worker node)

* sever node
* container runtime (e.g. docker)
* kublet interfaces with the node and the container runtime
* kube proxy - forwards services to nodes

* master nodes - 4 master processes
* api server - client cluster gateway and authentication (can be load balanced if multiple masters)
* scheduler - schedules start of pods on worker nodes with suitable resources. Kubelet actaully starts pod
* controller manager - detects pod death and reschedules/recover
* etcd key value store for the cluster state - application data NOT stored here - just cluster state info. Master nodes are also replicated and replicate key value information between master nodes

## local testing

Note tutorial expects mac with hypervisor etc

* minikube - one node cluster with master and worker processes and docker - can run on virtual box
* kubctl - talks to api server ( can also use UI/API or CLI kubctl) - for any kuberentes

## kubectl commands

```
kubectl get nodes
kubectl get pods
kubectl get services
```
create a pod - you cannot create pods directly - need to create a deployment.

```
# kubectl create deployment NAME --image=image
kubectl create deployment nginx-depl --image=nginx


kubectl get pod
NAME                          READY   STATUS    RESTARTS   AGE
nginx-depl-5796b5c499-bxb69   1/1     Running   0          81s
```
Deployments the basic configuration for the pod

```
kubectl get replicaset
NAME                    DESIRED   CURRENT   READY   AGE
nginx-depl-5796b5c499   1         1         1       3m30s

```

now we can see details of deployment. 

```
kubectl edit deployment nginx-depl
```

```
# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2024-12-17T14:46:47Z"
  generation: 1
  labels:
    app: nginx-depl
  name: nginx-depl
  namespace: default
  resourceVersion: "753"
  uid: 4ca3c4a4-4ea7-4ca1-85e3-1ba736ad0e11
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: nginx-depl
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx-depl
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 1
  conditions:
  - lastTransitionTime: "2024-12-17T14:47:47Z"
    lastUpdateTime: "2024-12-17T14:47:47Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2024-12-17T14:46:47Z"
    lastUpdateTime: "2024-12-17T14:47:47Z"
    message: ReplicaSet "nginx-depl-5796b5c499" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1
```

deployment
replicaset
pod
container(s)
image



pods are abstractions of containers

deployments are the way to instantiate pods

creating a deployment from kubectl CLI will create underlying resources from a blueprint

```
kubectl create deployment nginx-demo --image=nginx
```

this create deployment which you can see using

```
kubectl get deployment
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
nginx-demo   1/1     1            1           19s

```

you can edit the deployment using

```
kubectl edit deployment

```
change the line and exit the editor

```
    spec:
      containers:
      - image: nginx
```
to

```
    spec:
      containers:
      - image: nginx:1.16

```
Note VI is likely to indent yaml incorrectly for kubernetes add the following to ~/.vimrc
https://stackoverflow.com/questions/26962999/wrong-indentation-when-editing-yaml-in-vim

```
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

```
(to exit vi use esc : x)


1. create 
  191  kubectl delete deployment nginx-demo
  192  kubectl create deployment nginx-demo --image=nginx
  193  kubectl get deployment

  195  kubectl edit deployment nginx-demo
  196  kubectl get deployment
  197  kubectl edit deployment nginx-demo
  198  kubctl gggget pod
  199  kubectl get pod
  200  kubectl edit deployment nginx-demo
  201  kubectl get pod
  202  kubectl get deployment
  203  kubectl get replicaset
  204  kubectl get deployment
  205  kubectl edit deployment nginx-demo

```
kubectl get replicaset
```
note that by default 10 replicasets are stored - this allows roll back to previous replicasets.
can be changed in deployment

```
apiVersion: apps/v1
kind: Deployment
# ...
spec:
  # ...
  revisionHistoryLimit: 0 # Default to 10 if not specified
  # ...

```


deployment
manages
replicaset (managed by deployments)
manages
pods
abstraction of a
container

# debugging pods

kubectl describe <podname>
(note events at end)

```
kubectl describe pod nginx-demo-757b6f5c7c-wpzdj
Name:             nginx-demo-757b6f5c7c-wpzdj
Namespace:        default
Priority:         0
Service Account:  default
Node:             minikube/192.168.49.2
Start Time:       Wed, 18 Dec 2024 09:58:13 +0000
Labels:           app=nginx-demo
                  pod-template-hash=757b6f5c7c
Annotations:      <none>
Status:           Running
IP:               10.244.0.12
IPs:
  IP:           10.244.0.12
Controlled By:  ReplicaSet/nginx-demo-757b6f5c7c
Containers:
  nginx:
    Container ID:   docker://369561b2bc047599d388c4376ebed202b161dcf68a72a05c5bf31f6a5f2a50aa
    Image:          nginx:1.16
    Image ID:       docker-pullable://nginx@sha256:d20aa6d1cae56fd17cd458f4807e0de462caf2336f0b70b5eeb69fcaaf30dd9c
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Wed, 18 Dec 2024 09:58:15 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-476vm (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-476vm:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  35m   default-scheduler  Successfully assigned default/nginx-demo-757b6f5c7c-wpzdj to minikube
  Normal  Pulling    35m   kubelet            Pulling image "nginx:1.16"
  Normal  Pulled     35m   kubelet            Successfully pulled image "nginx:1.16" in 1.186s (1.186s including waiting). Image size: 126681697 bytes.
  Normal  Created    35m   kubelet            Created container nginx
  Normal  Started    35m   kubelet            Started container nginx
[admin@vbox devel]$ 

```

kubectl logs <podname>

```
# create new pod 
kubectl create deployment mongo-depl --image=mongo
deployment.apps/mongo-depl created

kubectl get deployment
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
mongo-depl   0/1     1            0           24s
nginx-demo   1/1     1            1           51m

kubectl get pod
NAME                          READY   STATUS              RESTARTS   AGE
mongo-depl-67d7db846c-gzxg6   0/1     ContainerCreating   0          2m10s
nginx-demo-757b6f5c7c-wpzdj   1/1     Running             0          43m
```
look at logs

```
kubectl logs mongo-depl-67d7db846c-gzxg6

WARNING: MongoDB 5.0+ requires a CPU with AVX support, and your current system does not appear to have that!
  see https://jira.mongodb.org/browse/SERVER-54407
  see also https://www.mongodb.com/community/forums/t/mongodb-5-0-cpu-intel-g4650-compatibility/116610/2
  see also https://github.com/docker-library/mongo/issues/485#issuecomment-891991814

```

need to use old mongo The latest version that can work WITHOUT AVX is
image: mongo:4.4.18

```
kubectl create deployment mongo-depl --image=mongo:4.4.18
deployment.apps/mongo-depl created

kubectl get pod
NAME                         READY   STATUS    RESTARTS   AGE
mongo-depl-9dd8c6768-wctcl   1/1     Running   0          5m17s

kubectl logs -f mongo-depl-9dd8c6768-wctcl

```

to exec inside a pod use

```
kubectl exec -it [podname] -- bin/bash
kubectl exec  -it mongo-depl-9dd8c6768-wctcl -- bin/bash
root@mongo-depl-9dd8c6768-wctcl:/# 
```
Note: The double dash (--) separates the arguments you want to pass to the command from the kubectl arguments.

## deleting deployments

kubectl delete deployment [name]

```
kubectl delete deployment mongo-depl
```

## applying configuration files
```
kubectl apply -f nginx-deployment.yaml

```
#configuration files

3 parts - 
metadata
specification
status - automatically generated by kubernetes - desired vs actual state
status data from etcd - current status of kubernetes component

yaml validator online
store configuration with code or speerate git repository

deployent manageds a replicaset manages apod abstraction of conteiner

deployment has a template - blueprint for a pod

Labels and selectors
metadate conteins lables
template conteins selectors

ports 
service ports -  where hte service is accessible

pod ports target container port


kubectl apply -f nginx-deployment.yaml 
deployment.apps/nginx-deployment created
kubectl apply -f nginx-service.yaml 
service/nginx-service created

ubectl get pod
NAME                               READY   STATUS    RESTARTS   AGE
nginx-deployment-fb4cbd588-2sz5d   1/1     Running   0          12m
nginx-deployment-fb4cbd588-4b9wg   1/1     Running   0          12m


kubectl get service
NAME            TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)   AGE
kubernetes      ClusterIP   10.96.0.1        <none>        443/TCP   25h
nginx-service   ClusterIP   10.105.138.106   <none>        80/TCP    3m30s
dkubectl describe service nginx-service
Name:                     nginx-service
Namespace:                default
Labels:                   <none>
Annotations:              <none>
Selector:                 app=nginx
Type:                     ClusterIP
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.105.138.106
IPs:                      10.105.138.106
Port:                     <unset>  80/TCP
TargetPort:               8080/TCP
Endpoints:                10.244.0.19:8080,10.244.0.20:8080
Session Affinity:         None
Internal Traffic Policy:  Cluster
Events:                   <none>

check these are the right pods

note that Endpoints of service match nginx pods

kubectl get pod -o wide
NAME                               READY   STATUS    RESTARTS   AGE   IP            NODE       NOMINATED NODE   READINESS GATES
nginx-deployment-fb4cbd588-2sz5d   1/1     Running   0          20m   10.244.0.19   minikube   <none>           <none>
nginx-deployment-fb4cbd588-4b9wg   1/1     Running   0          20m   10.244.0.20   minikube   <none>           <none>


now find the state of the deployment

kubectl get deployment nginx-deployment
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   2/2     2            2           28m


kubectl get deployment nginx-deployment -o yaml

(note kubectl.kubernetes.io/last-applied-configuration: |   The pipe | (vertical bar) is used when you want newlines to be kept as newlines.

```
kubectl get deployment nginx-deployment -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"labels":{"app":"nginx"},"name":"nginx-deployment","namespace":"default"},"spec":{"replicas":2,"selector":{"matchLabels":{"app":"nginx"}},"template":{"metadata":{"labels":{"app":"nginx"}},"spec":{"containers":[{"image":"nginx:1.16","name":"nginx","ports":[{"containerPort":80}]}]}}}}
  creationTimestamp: "2024-12-18T15:44:57Z"
  generation: 1
  labels:
    app: nginx
  name: nginx-deployment
  namespace: default
  resourceVersion: "28075"
  uid: 44826d49-87f2-43f6-bbbf-06241a129452
spec:
  progressDeadlineSeconds: 600
  replicas: 2
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: nginx
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx:1.16
        imagePullPolicy: IfNotPresent
        name: nginx
        ports:
        - containerPort: 80
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 2
  conditions:
  - lastTransitionTime: "2024-12-18T15:45:01Z"
    lastUpdateTime: "2024-12-18T15:45:01Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2024-12-18T15:44:57Z"
    lastUpdateTime: "2024-12-18T15:45:01Z"
    message: ReplicaSet "nginx-deployment-fb4cbd588" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 2
  replicas: 2
  updatedReplicas: 2
[admin@vbox devel]$ 
```

you can use this to create a new deployment but you must remove the additional metadata which is generated

```
kubectl delete nginx-deployment.yaml
```

# Example real application - mongo db and mongo express

you can see deployment documentation here https://kubernetes.io/docs/concepts/workloads/controllers/deployment/

container spec is here https://hub.docker.com/_/mongo
we need to use tag mongo:4.4.18

to create usernames and passwords you need to use base64 encodng

```
echo -n 'username' | base64
dXNlcm5hbWU=
echo -n 'password' | base64
cGFzc3dvcmQ=
```

note create secret before deployment

```
kubectl apply -f mongodb-secret.yaml
secret/mongodb-secret created

kubectl get secret
NAME             TYPE     DATA   AGE
mongodb-secret   Opaque   2      11s
```

create service in same file https://kubernetes.io/docs/concepts/services-networking/service/

mongo express https://hub.docker.com/_/mongo-express

```
kubectl apply -f mongodb-configmap.yml 
kubectl apply -f mongodb-secret.yaml 
kubectl apply -f mongo-express.yaml 
kubectl apply -f mongo.yaml 

kubectl get all
NAME                                    READY   STATUS    RESTARTS   AGE
pod/mongo-deployment-654874b47f-cfbj9   1/1     Running   0          95s
pod/mongo-express-85d8576d55-gvz9r      1/1     Running   0          106s

NAME                            TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/kubernetes              ClusterIP      10.96.0.1       <none>        443/TCP          27h
service/mongo-express-service   LoadBalancer   10.98.187.226   <pending>     8081:30000/TCP   106s
service/mongodb-service         ClusterIP      10.99.146.90    <none>        27017/TCP        95s

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mongo-deployment   1/1     1            1           95s
deployment.apps/mongo-express      1/1     1            1           106s

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/mongo-deployment-654874b47f   1         1         1       95s
replicaset.apps/mongo-express-85d8576d55      1         1         1       106s
```
note that ClusterIP is the default name for an internal service ip

note that service/mongo-express-service   external ip addres is pending. We can only assign this in minikube

```
inikube service mongo-express-service
|-----------|-----------------------|-------------|---------------------------|
| NAMESPACE |         NAME          | TARGET PORT |            URL            |
|-----------|-----------------------|-------------|---------------------------|
| default   | mongo-express-service |        8081 | http://192.168.49.2:30000 |
|-----------|-----------------------|-------------|---------------------------|
🎉  Opening service default/mongo-express-service in default browser...
```
note default username  admin 
default password pass

# namespaces

namespace - organise resources in namespaces - a virtual cluster wihin a kubernetes cluster

```
kubectl get namespace
NAME              STATUS   AGE
default           Active   42h  # used to create resources if haven't created new name space
kube-node-lease   Active   42h  # heartbeats of nodes  - availability
kube-public       Active   42h  # publicly accessible date without authentication
kube-system       Active   42h  # not meant for user - system processes

```

```
kubectl cluster-info 
Kubernetes control plane is running at https://192.168.49.2:8443
CoreDNS is running at https://192.168.49.2:8443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
```

```
kubectl get pods --all-namespaces -o wide
NAMESPACE     NAME                                READY   STATUS    RESTARTS   AGE   IP             NODE       NOMINATED NODE   READINESS GATES
default       mongo-deployment-654874b47f-cfbj9   1/1     Running   0          15h   10.244.0.24    minikube   <none>           <none>
default       mongo-express-85d8576d55-gvz9r      1/1     Running   0          15h   10.244.0.23    minikube   <none>           <none>
kube-system   coredns-6f6b679f8f-ktsqk            1/1     Running   0          43h   10.244.0.2     minikube   <none>           <none>
kube-system   etcd-minikube                       1/1     Running   0          43h   192.168.49.2   minikube   <none>           <none>
kube-system   kube-apiserver-minikube             1/1     Running   0          43h   192.168.49.2   minikube   <none>           <none>
kube-system   kube-controller-manager-minikube    1/1     Running   0          43h   192.168.49.2   minikube   <none>           <none>
kube-system   kube-proxy-4dtbq                    1/1     Running   0          43h   192.168.49.2   minikube   <none>           <none>
kube-system   kube-scheduler-minikube             1/1     Running   0          43h   192.168.49.2   minikube   <none>           <none>
kube-system   storage-provisioner                 1/1     Running   3          43h   192.168.49.2   minikube   <none>           <none>

```

create a namespace - can also be created in a ConfigMap

```
kubectl create namespace my-namespace
kubectl get namespace 
NAME              STATUS   AGE
default           Active   43h
kube-node-lease   Active   43h
kube-public       Active   43h
kube-system       Active   43h
my-namespace      Active   7s

```
usage - create namespaces for specific resources logically
e.g. database, monitoring, elastic etc

* many teams same application - helps with different teams using same application in differnt namespaces
* staging and development in same cluster - can use common resources in 
* blue green deployment - different versions of production systems - using same nginx controller etc
* access limits on namespaces e.g. per names apce resource quotas etc

cant access resources from another namespace - secrets , config map - must recreate
can share services across namespaces  - can access services from other namespaces e.g.

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: mysql-configmap
data:
  db_url: mysql-service.database
```
The database namespace is suffix to mysql-service
some components an be in a namespace - e.g. node and volume

```
kubectl api-resources --namespaced=false
kubectl api-resources --namespaced=true
```

kubectl apply creates in default namespace 

```
kubectl get configmap
same as
kubectl get configmap -n default 

kubectl get configmap -o yaml

```

can create a reourse in a namspace using
```
kubectl apply -f msql-configmap.yaml --namesapce=my-namesapce
```
or include namespace in matadata of resource  (best practice)

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: mysql-configmap
  namespace: my-namespace
data:
  db_url: mysql-service.database

```

Tool to manage active namespace - rather than using it with kubectl all the time
see https://github.com/ahmetb/kubectx 
kubectx is a tool to switch between contexts (clusters) on kubectl faster.
kubens is a tool to switch between Kubernetes namespaces (and configure them for kubectl) easily.

## kubernetes ingress vs external service

external service - quick deployment but only http ( no https)

```
apiVersion: v1
kind: Service
metadata:
  name: myapp-internal-service
spec:
  selector:
    app: myapp
    # defaults to type: ClusterIP (internal service)
  ports:
    - protocol: TCP
      port: 8080
      targetPort: 8080
      # no nodePort since internal service

```
usual deployment - my-app service (internal) my-app ingres - external

routing rules - host in browser mapped to service paths - is url path after domain name

```
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: myapp-ingress
spec:
  rules:
  - host: myapp.com
    http:
      paths
       -backend:
          serviceName: myapp-internal-service
          servicePort:8080

```

you need an implementation of ingress  - an ingress controller pod
K8s Nginx ingress controller

cloud load balancer - redirect to k8s load balancer - minimal effort
basre metal deploy - need a n entryp ont - either inside cluster or external server - proxy server

minikube  -similar install ingress controller

```
minikube addons enable ingress
💡  ingress is an addon maintained by Kubernetes. For any concerns contact minikube on GitHub.
You can view the list of minikube maintainers at: https://github.com/kubernetes/minikube/blob/master/OWNERS
    ▪ Using image registry.k8s.io/ingress-nginx/controller:v1.11.2
    ▪ Using image registry.k8s.io/ingress-nginx/kube-webhook-certgen:v1.4.3
    ▪ Using image registry.k8s.io/ingress-nginx/kube-webhook-certgen:v1.4.3
🔎  Verifying ingress addon...

🌟  The 'ingress' addon is enabled

## check pod available
kubectl get pods --all-namespaces
NAMESPACE       NAME                                       READY   STATUS      RESTARTS   AGE
default         mongo-deployment-654874b47f-cfbj9          1/1     Running     0          16h
default         mongo-express-85d8576d55-gvz9r             1/1     Running     0          16h
ingress-nginx   ingress-nginx-admission-create-zs9q6       0/1     Completed   0          10m
ingress-nginx   ingress-nginx-admission-patch-r4vq6        0/1     Completed   0          10m
ingress-nginx   ingress-nginx-controller-bc57996ff-d29ml   1/1     Running     0          10m
kube-system     coredns-6f6b679f8f-ktsqk                   1/1     Running     0          44h
kube-system     etcd-minikube                              1/1     Running     0          44h
kube-system     kube-apiserver-minikube                    1/1     Running     0          44h
kube-system     kube-controller-manager-minikube           1/1     Running     0          44h
kube-system     kube-proxy-4dtbq                           1/1     Running     0          44h
kube-system     kube-scheduler-minikube                    1/1     Running     0          44h
kube-system     storage-provisioner                        1/1     Running     3          44h

```

enable kubernetes dashboard

```
minikube addons list

minikube addons enable dashboard

kubectl get all -n kubernetes-dashboard
NAME                                            READY   STATUS    RESTARTS   AGE
pod/dashboard-metrics-scraper-c5db448b4-wpsqz   1/1     Running   0          2m5s
pod/kubernetes-dashboard-695b96c756-7fcr6       1/1     Running   0          2m5s

NAME                                TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/dashboard-metrics-scraper   ClusterIP   10.109.178.176   <none>        8000/TCP   2m4s
service/kubernetes-dashboard        ClusterIP   10.102.172.6     <none>        80/TCP     2m5s

NAME                                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/dashboard-metrics-scraper   1/1     1            1           2m6s
deployment.apps/kubernetes-dashboard        1/1     1            1           2m6s

NAME                                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/dashboard-metrics-scraper-c5db448b4   1         1         1       2m6s
replicaset.apps/kubernetes-dashboard-695b96c756       1         1         1       2m5s

```

create dashboard-ingress.yaml

(note tutorial api version wrong - check api versions kubectl api-versions)
kubectl apply -f dashboard-ingress.yaml

kubectl get ingress -n kuberentes-dashboard --watch

edit hosts file to include mapping for kubernetes-dashboard.com



```
sudo nano /etc/hosts
```

# 5 things you need to know before kubernetes:

[site reliability engineer k8s foundational concepts] https://www.youtube.com/watch?v=wXuSqFJVNQA
* 2022 96% organisations evaluating or using k8s  - good time to learn

1. understand containerisation - docker file build image which becomes a container. Learn docker etc
2. cloud basics - deploy kubernetes in cloud identity access / logging etc - cloud platform for kubernetes hosting - AWS cloud practitioner course. Can get expensive very quick
3. yaml superset of json - declaritive programming - manifest file defines desired state 
4. networking basics - not often taught to programmers - need a base understanding of linux networking 
5. terminal proficiency - kubectl vi/nano editor etc - 

Recommends Video Resources

[Learn Docker in One Hour - Docker For Beginners](https://www.youtube.com/watch?v=i7ABlHngi1Q&t=0s) 

[Learn AWS Networking For Programmers](https://www.youtube.com/watch?v=2doSoMN2xvI&t=0s)

[Networking Video- Computer Networking Full Course](https://www.youtube.com/watch?v=IPvYjXCsTg8&t=0s)

[YAML article](https://www.cloudbees.com/blog/yaml-tutorial-everything-you-need-get-started)

[Kubernetes Udemy Course Recommendation](https://geni.us/KciFOCO)
 






