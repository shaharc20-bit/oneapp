# Kubernetes manifests (Section 7)

- `namespace.yaml` - `flask-monitor`
- `deployment.yaml` - 2 replicas of `shaharc20/flask-aws-monitor:latest`, port 5001, probes on `/health`, AWS keys from secret `aws-credentials`
- `service.yaml` - LoadBalancer on port 5001
- `aws-secret.example.yaml` - example only, create the real secret with kubectl (only needed outside EC2)
- `install_k3s.sh` - single-node k3s + helm on the builder

Cluster: k3s on the builder (`./install_k3s.sh`, installs k3s + helm). The pods read AWS through the builder IAM role, so the secret is optional (`optional: true`).

```bash
./install_k3s.sh
kubectl apply -f namespace.yaml
kubectl create secret generic aws-credentials -n flask-monitor \
  --from-literal=AWS_ACCESS_KEY_ID=... \
  --from-literal=AWS_SECRET_ACCESS_KEY=...
kubectl apply -f deployment.yaml -f service.yaml
kubectl get pods,svc -n flask-monitor
```
Open `http://<EXTERNAL-IP>:5001/` (no LoadBalancer: `kubectl port-forward svc/flask-aws-monitor -n flask-monitor 5001:5001`).
