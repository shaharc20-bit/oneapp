#!/bin/bash
# ממיר את כתובת ה-IP של ה-pod לפורמט DNS של Kubernetes (נקודות -> מקפים)
POD_IP=$(kubectl get pod nginx-resolver -o jsonpath='{.status.podIP}')
POD_IP_DASH=$(echo "$POD_IP" | tr '.' '-')

kubectl run tmp-dns2 --image=busybox:1.28 --restart=Never -- sleep 3600
kubectl wait --for=condition=Ready pod/tmp-dns2 --timeout=60s

kubectl exec tmp-dns2 -- nslookup "${POD_IP_DASH}.default.pod.cluster.local" > /root/nginx-shahar.pod

kubectl delete pod tmp-dns2
