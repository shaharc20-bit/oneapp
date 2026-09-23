#!/bin/bash
cd "$(dirname "$0")/../05-configmap"
cat config.txt
kubectl create cm keyvalcfgmap --from-env-file=config.txt
kubectl apply -f nginx-pod.yaml
kubectl exec nginx -- printenv | grep key
