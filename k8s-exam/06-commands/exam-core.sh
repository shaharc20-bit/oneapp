#!/usr/bin/env bash
set -euo pipefail
NAME="${NAME:-shahar}"
kubectl run "nginx-pod-${NAME}" --image=nginx:alpine
kubectl run messaging --image=redis:alpine --labels=tier=msg
kubectl create namespace "apx-x998-${NAME}"
kubectl get nodes -o json > "/tmp/nodes-${NAME}"
kubectl expose pod messaging --name=messaging-service --port=6379 --target-port=6379 --type=ClusterIP
kubectl create deployment hr-web-app --image=kodekloud/webapp-color --replicas=2
echo "Q8 static: sudo cp 01-exam-core/08-static-busybox.yaml /etc/kubernetes/manifests/static-busybox.yaml"
kubectl create namespace "finance-${NAME}" --dry-run=client -o yaml | kubectl apply -f -
kubectl run temp-bus --image=redis:alpine -n "finance-${NAME}"
kubectl apply -f 01-exam-core/10-pv-analytics.yaml
kubectl apply -f 01-exam-core/11-redis-storage.yaml
kubectl apply -f 01-exam-core/12-pv-1.yaml
kubectl apply -f 01-exam-core/12-use-pv.yaml
kubectl create deployment nginx-deploy --image=nginx:1.16 --replicas=1
kubectl set image deployment/nginx-deploy nginx=nginx:1.17 --record || kubectl set image deployment/nginx-deploy nginx=nginx:1.17
kubectl annotate deployment/nginx-deploy kubernetes.io/change-cause="upgrade to nginx:1.17" --overwrite
kubectl run nginx-resolver --image=nginx --labels=app=nginx-resolver
kubectl expose pod nginx-resolver --name=nginx-resolver-service --port=80 --target-port=80
kubectl apply -f 01-exam-core/16-multi-pod.yaml
