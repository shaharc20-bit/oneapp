# k8s exam

שחר כהן

```
kubectl apply -f 01-exam-core/
kubectl apply -f 02-pod-design/
kubectl apply -f 03-deployments/
kubectl apply -f 04-jobs/
kubectl apply -f 05-configmap/
```

```
chmod +x apply-all.sh
./apply-all.sh
```

helm:

```
helm upgrade --install oneapp-exam ./chart
```

static pods להעתיק ל /etc/kubernetes/manifests
