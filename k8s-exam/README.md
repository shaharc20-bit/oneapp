# k8s exam

שחר כהן

```
./apply-all.sh   # 08 ו-15 הם static pods, ראה למטה
kubectl apply -f 02-pod-design/
kubectl apply -f 03-deployments/
kubectl apply -f 04-jobs/
kubectl apply -f 05-configmap/
```

```
chmod +x apply-all.sh
./apply-all.sh
```

static pods (8, 15):

```
./06-commands/static-pods.sh
```

hpa דורש metrics-server:

```
minikube addons enable metrics-server
```

helm:

```
helm upgrade --install oneapp-exam ./chart
```


