#!/bin/bash
set -e
cd "$(dirname "$0")/.."

echo "=== מחזור 1: webapp עם nginx, 5 עותקים ==="
kubectl apply -f 03-deployments/webapp-v1.yaml
kubectl rollout status deploy/webapp
kubectl get rs
kubectl get rs -o yaml > 03-deployments/webapp-rs.yaml
kubectl get pods -l app=webapp -o yaml > 03-deployments/webapp-pods.yaml

echo "=== מוחקים את ה-Deployment ומוודאים שה-Pods נעלמו ==="
kubectl delete deploy webapp
sleep 5
kubectl get pods -l app=webapp

echo "=== מחזור 2: webapp חדש עם nginx:1.17.1, פורט 80 ==="
kubectl apply -f 03-deployments/webapp.yaml
kubectl rollout status deploy/webapp
kubectl get deploy webapp -o jsonpath='{.spec.template.spec.containers[0].image}{"\n"}'

kubectl set image deploy/webapp nginx=nginx:1.17.4
kubectl rollout history deploy/webapp
kubectl rollout undo deploy/webapp
kubectl get deploy webapp -o jsonpath='{.spec.template.spec.containers[0].image}{"\n"}'

kubectl set image deploy/webapp nginx=nginx:1.100
kubectl get pods
kubectl rollout undo deploy/webapp
kubectl set image deploy/webapp nginx=nginx:latest
kubectl rollout history deploy/webapp --revision=7

echo "=== HPA (אימפרטיבי, לא בקובץ YAML) ==="
kubectl autoscale deploy webapp --min=10 --max=20 --cpu-percent=85
kubectl get hpa

echo "=== ניקוי ==="
kubectl delete deploy webapp
kubectl delete hpa webapp
