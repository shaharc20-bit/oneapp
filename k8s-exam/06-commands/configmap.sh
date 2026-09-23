#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../05-configmap"

echo "== 1. config.txt =="
cat config.txt

echo "== 2. ConfigMap from file =="
kubectl create configmap keyvalcfgmap --from-env-file=config.txt
kubectl get configmap keyvalcfgmap -o yaml

echo "== 3. nginx pod with envFrom =="
kubectl apply -f nginx-pod.yaml
kubectl wait --for=condition=Ready pod/nginx --timeout=60s
kubectl exec nginx -- printenv | grep -E 'key1|key2'
