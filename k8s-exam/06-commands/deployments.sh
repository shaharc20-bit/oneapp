#!/usr/bin/env bash
set -euo pipefail
echo "== webapp rollout / rollback / HPA =="
kubectl apply -f 03-deployments/webapp.yaml || true
kubectl rollout status deploy/webapp || true
kubectl get rs -l app=webapp
kubectl set image deploy/webapp nginx=nginx:1.17.4
kubectl annotate deploy/webapp kubernetes.io/change-cause="upgrade to nginx:1.17.4" --overwrite
kubectl rollout history deploy/webapp
kubectl rollout undo deploy/webapp
kubectl set image deploy/webapp nginx=nginx:1.100 || true
kubectl rollout undo deploy/webapp || true
kubectl autoscale deploy webapp --min=10 --max=20 --cpu-percent=85 || true
kubectl get hpa webapp || true
