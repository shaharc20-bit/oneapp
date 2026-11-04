#!/usr/bin/env bash
set -euo pipefail

curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644

mkdir -p "$HOME/.kube"
cp /etc/rancher/k3s/k3s.yaml "$HOME/.kube/config"
chmod 600 "$HOME/.kube/config"

if ! command -v helm > /dev/null; then
  curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
fi

kubectl get nodes -o wide
helm version
