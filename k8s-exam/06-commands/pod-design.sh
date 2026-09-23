#!/bin/bash
kubectl get pods --show-labels
kubectl run nginx-prod-1 --image=nginx --labels=env=prod,app=nginx
kubectl run nginx-prod-2 --image=nginx --labels=env=prod,app=nginx
kubectl run nginx-dev-1 --image=nginx --labels=env=dev,app=nginx
kubectl run nginx-dev-2 --image=nginx --labels=env=dev,app=nginx
kubectl run nginx-dev-3 --image=nginx --labels=env=dev,app=nginx
kubectl get pods -l env=dev --show-labels
kubectl get pods -l env=prod --show-labels
kubectl get pods -l env
kubectl get pods -l 'env in (dev,prod)' --show-labels
kubectl label pod nginx-prod-1 env=uat --overwrite
kubectl label pod nginx-prod-1 nginx-prod-2 nginx-dev-1 nginx-dev-2 nginx-dev-3 env-
kubectl label pod nginx-prod-1 nginx-prod-2 nginx-dev-1 nginx-dev-2 nginx-dev-3 app=nginx --overwrite
kubectl get nodes --show-labels
NODE=$(kubectl get nodes -o jsonpath='{.items[0].metadata.name}')
kubectl label node $NODE nodeName=nginxnode --overwrite
kubectl apply -f 02-pod-design/nginx-nodeselector.yaml
