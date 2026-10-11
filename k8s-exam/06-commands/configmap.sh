#!/bin/bash
cd "$(dirname "$0")/../05-configmap"
cat config.txt
kubectl create cm keyvalcfgmap --from-env-file=config.txt --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f nginx-pod.yaml
kubectl exec nginx -- printenv | grep key
kubectl get cm keyvalcfgmap -o yaml
kubectl delete pod nginx
