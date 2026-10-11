#!/bin/bash
# 8 - static pod on the master node
sudo cp "$(dirname "$0")/../01-exam-core/08-static-busybox.yaml" /etc/kubernetes/manifests/static-busybox.yaml

# 15 - static pod on node01 (kubelet restarts it automatically)
scp "$(dirname "$0")/../01-exam-core/15-nginx-critical.yaml" node01:/tmp/nginx-critical.yaml
ssh node01 "sudo cp /tmp/nginx-critical.yaml /etc/kubernetes/manifests/nginx-critical.yaml"

kubectl get pods -o wide | grep -E 'static-busybox|nginx-critical'
