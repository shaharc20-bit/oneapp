#!/bin/bash
kubectl apply -f 03-deployments/webapp.yaml
kubectl rollout status deploy/webapp
kubectl get rs
kubectl get rs -o yaml > 03-deployments/webapp-rs.yaml
kubectl get pods -l app=webapp -o yaml > 03-deployments/webapp-pods.yaml
kubectl set image deploy/webapp nginx=nginx:1.17.4
kubectl rollout history deploy/webapp
kubectl rollout undo deploy/webapp
kubectl set image deploy/webapp nginx=nginx:1.100
kubectl get pods
kubectl rollout undo deploy/webapp
kubectl set image deploy/webapp nginx=nginx:latest
kubectl rollout history deploy/webapp --revision=7
kubectl autoscale deploy webapp --min=10 --max=20 --cpu-percent=85
kubectl get hpa
kubectl delete deploy webapp
kubectl delete hpa webapp
