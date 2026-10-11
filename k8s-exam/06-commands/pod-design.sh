#!/bin/bash
kubectl get pods --show-labels
kubectl run nginx-prod-1 --image=nginx --labels=env=prod
kubectl run nginx-prod-2 --image=nginx --labels=env=prod
kubectl run nginx-dev-1 --image=nginx --labels=env=dev
kubectl run nginx-dev-2 --image=nginx --labels=env=dev
kubectl run nginx-dev-3 --image=nginx --labels=env=dev
kubectl get pods --show-labels
kubectl get pods -l env=dev
kubectl get pods -l env=dev --show-labels
kubectl get pods -l env=prod
kubectl get pods -l env=prod --show-labels
kubectl get pods -l env
kubectl get pods -l 'env in (dev,prod)'
kubectl get pods -l 'env in (dev,prod)' --show-labels
kubectl label pod nginx-prod-1 env=uat --overwrite
kubectl get pods --show-labels
kubectl label pod nginx-prod-1 nginx-prod-2 nginx-dev-1 nginx-dev-2 nginx-dev-3 env-
kubectl get pods --show-labels
kubectl label pod nginx-prod-1 nginx-prod-2 nginx-dev-1 nginx-dev-2 nginx-dev-3 app=nginx --overwrite
kubectl get pods --show-labels
kubectl get nodes --show-labels
NODE=$(kubectl get nodes -o jsonpath='{.items[0].metadata.name}')
kubectl label node $NODE nodeName=nginxnode --overwrite
kubectl apply -f 02-pod-design/nginx-nodeselector.yaml
kubectl get pod nginx -o wide
kubectl get pod nginx --show-labels
