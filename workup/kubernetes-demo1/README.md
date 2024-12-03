kubernetes demo

installation

https://minikube.sigs.k8s.io/docs/start/

see [Kubernetes Crash Course for Absolute Beginners(https://www.youtube.com/watch?v=s_o8dwzRlu4)

[Kubernetes Documentation](https://kubernetes.io/docs/home/)

demo app container [nanajanashia/k8s-demo-app](https://hub.docker.com/r/nanajanashia/k8s-demo-app)

installation

```
PS C:\devel\gitrepos\solent-work\COM614-cloud-computing\workup\kubernetes-demo1> minikube start
* minikube v1.34.0 on Microsoft Windows 11 Pro 10.0.22631.4541 Build 22631.4541
* Automatically selected the docker driver. Other choices: virtualbox, ssh
* Using Docker Desktop driver with root privileges
* Starting "minikube" primary control-plane node in "minikube" cluster
* Pulling base image v0.0.45 ...
* Creating docker container (CPUs=2, Memory=8100MB) ...
! Failing to connect to https://registry.k8s.io/ from both inside the minikube container and host machine
* To pull new external images, you may need to configure a proxy: https://minikube.sigs.k8s.io/docs/reference/networking/proxy/
* Preparing Kubernetes v1.31.0 on Docker 27.2.0 ...
  - Generating certificates and keys ...
  - Booting up control plane ...
  - Configuring RBAC rules ...
* Configuring bridge CNI (Container Networking Interface) ...
* Verifying Kubernetes components...
  - Using image gcr.io/k8s-minikube/storage-provisioner:v5
* Enabled addons: storage-provisioner, default-storageclass
* Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default


```
remove all clusters

```
PS C:\devel\gitrepos\solent-work\COM614-cloud-computing\workup\kubernetes-demo1> minikube delete --all
* Deleting "minikube" in docker ...
* Removing C:\Users\cg02r\.minikube\machines\minikube ...
* Removed all traces of the "minikube" cluster.
* Successfully deleted all profiles
```


[kubernetes config map](https://kubernetes.io/docs/concepts/configuration/configmap/)

[kubernetes secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
(see basic authentication secret)

in powershell

```
echo -n mongouser | base64
bW9uZ291c2VyDQo=

 echo -n mongopassword | base64
bW9uZ29wYXNzd29yZA0K
```

[kubernetes deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)

using [mongo 5.0 container](https://hub.docker.com/layers/library/mongo/5.0/images/sha256-02425a4d2150ff04e01a515388f4190d4dcc73b1912a5be5c993eda18bb07412?context=explore)

see [mongo container documentation](https://hub.docker.com/_/mongo)  standard mongodb port 27017

[service configuration](https://kubernetes.io/docs/concepts/services-networking/service/)

now deploy the files:

```
cd kubernets-demo1

kubectl apply -f mongo-config.yaml
kubectl apply -f mongo-secret.yaml
kubectl apply -f mongo.yaml
kubectl apply -f webapp.yaml
```

https://stackoverflow.com/questions/71536310/unable-to-access-minikube-ip-address  NOTE exactly the same tutorial problem Unable to access minikube IP address [closed]




```
kubectl get all

NAME                                     READY   STATUS                       RESTARTS   AGE
pod/mongo-deployment-798f55b8-ptvzd      1/1     Running                      0          5m4s
pod/webapp-deployment-5c75cd8d66-8xp2w   0/1     CreateContainerConfigError   0          5m

NAME                     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/kubernetes       ClusterIP   10.96.0.1        <none>        443/TCP          109m
service/mongo-service    ClusterIP   10.110.183.8     <none>        27017/TCP        5m4s
service/webapp-service   NodePort    10.108.194.236   <none>        3000:30100/TCP   5m

NAME                                READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mongo-deployment    1/1     1            1           5m4s
deployment.apps/webapp-deployment   0/1     1            0           5m

NAME                                           DESIRED   CURRENT   READY   AGE
replicaset.apps/mongo-deployment-798f55b8      1         1         1       5m4s
replicaset.apps/webapp-deployment-5c75cd8d66   1         1         0       5m
```

```
kubectl get secret
NAME           TYPE     DATA   AGE
mongo-secret   Opaque   2      34m

kubectl get configmap
NAME               DATA   AGE
kube-root-ca.crt   1      138m
mongo-config       1      35m
```

getting the ip address of the service

```
minikube ip
192.168.49.2

or 

kubectl get node -o wide
NAME       STATUS   ROLES           AGE    VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION                       CONTAINER-RUNTIME
minikube   Ready    control-plane   145m   v1.31.0   192.168.49.2   <none>        Ubuntu 22.04.4 LTS   5.15.167.4-microsoft-standard-WSL2   docker://27.2.0
```


