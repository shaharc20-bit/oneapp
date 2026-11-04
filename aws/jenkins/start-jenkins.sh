#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

DOCKER_GID="$(getent group docker | cut -d: -f3)"
export DOCKER_GID

sudo mkdir -p /var/jenkins_home
sudo chown 1000:1000 /var/jenkins_home

docker compose up -d --build

echo "Waiting for Jenkins to start..."
until docker exec jenkins test -f /var/jenkins_home/secrets/initialAdminPassword 2>/dev/null; do
  sleep 5
done

PUBLIC_IP="$(curl -s https://checkip.amazonaws.com || hostname -I | awk '{print $1}')"
echo "Jenkins URL:           http://${PUBLIC_IP}:8080"
echo "Initial admin password: $(docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword)"
