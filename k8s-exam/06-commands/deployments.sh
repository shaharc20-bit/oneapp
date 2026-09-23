#!/bin/bash
kubectl apply -f 03-deployments/webapp.yaml
kubectl rollout status deploy/webapp
kubectl get rs
kubectl set image deploy/webapp nginx=nginx:1.17.4
kubectl rollout history deploy/webapp
kubectl rollout undo deploy/webapp
kubectl set image deploy/webapp nginx=nginx:1.100
kubectl get pods
kubectl rollout undo deploy/webapp
kubectl set image deploy/webapp nginx=nginx:latest
kubectl autoscale deploy webapp --min=10 --max=20 --cpu-percent=85
kubectl get hpa
