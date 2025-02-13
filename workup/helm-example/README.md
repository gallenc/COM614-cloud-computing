taken from https://devopscube.com/create-helm-chart/



Install Helm
for windows https://phoenixnap.com/kb/install-helm

```
kubectl apply -f - <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: odacomponent-account
EOF
```