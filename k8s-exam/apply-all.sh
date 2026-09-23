#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"
kubectl apply -f 01-exam-core/03-namespace.yaml
kubectl apply -f 01-exam-core/01-nginx-pod.yaml
kubectl apply -f 01-exam-core/02-messaging-pod.yaml
kubectl apply -f 01-exam-core/05-messaging-service.yaml
kubectl apply -f 01-exam-core/07-hr-web-app.yaml
kubectl apply -f 01-exam-core/09-temp-bus.yaml
kubectl apply -f 01-exam-core/10-pv-analytics.yaml
kubectl apply -f 01-exam-core/11-redis-storage.yaml
kubectl apply -f 01-exam-core/12-pv-1.yaml
kubectl apply -f 01-exam-core/12-use-pv.yaml
kubectl apply -f 01-exam-core/13-nginx-deploy.yaml
kubectl apply -f 01-exam-core/14-nginx-resolver.yaml
kubectl apply -f 01-exam-core/16-multi-pod.yaml
kubectl apply -f 02-pod-design/labeled-nginx-pods.yaml
kubectl apply -f 04-jobs/hello-job.yaml
kubectl apply -f 05-configmap/keyvalcfgmap.yaml
kubectl apply -f 05-configmap/nginx-pod.yaml
echo "Static pods: copy Q8/Q15 yaml into /etc/kubernetes/manifests/"
