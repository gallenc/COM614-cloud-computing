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




# 5 things you need to know before kubernetes:

[site reliability engineer k8s foundational concepts] https://www.youtube.com/watch?v=wXuSqFJVNQA
* 2022 96% organisations evaluating or using k8s  - good time to learn

1. understand containerisation - docker file build image which becomes a container. Learn docker etc
2. cloud basics - deploy kubernetes in cloud identity access / logging etc - cloud platform for kubernetes hosting - AWS cloud practitioner course. Can get expensive very quick
3. yaml superset of json - declaritive programming - manifest file defines desired state 
4. networking basics - not often taught to programmers - need a base understanding of linux networking 
5. terminal proficiency - kubctl vi/nano editor etc - 

Recommends Video Resources

[Learn Docker in One Hour - Docker For Beginners](https://www.youtube.com/watch?v=i7ABlHngi1Q&t=0s) 

[Learn AWS Networking For Programmers](https://www.youtube.com/watch?v=2doSoMN2xvI&t=0s)

[Networking Video- Computer Networking Full Course](https://www.youtube.com/watch?v=IPvYjXCsTg8&t=0s)

[YAML article](https://www.cloudbees.com/blog/yaml-tutorial-everything-you-need-get-started)

[Kubernetes Udemy Course Recommendation](https://geni.us/KciFOCO)
 






