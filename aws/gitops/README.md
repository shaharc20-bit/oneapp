# GitOps with Argo CD (Section 8)

```
gitops/
  charts/
    flask-aws-monitor/        Helm chart (same as aws/helm)
    stress-app/               stress-ng load generator chart
  flask-aws-monitor/
    dev/values.yaml
    qa/values.yaml
    prd/values.yaml
  stress-app/
    dev/values.yaml
    qa/values.yaml
    prd/values.yaml
  bonus-apps/
    nginx/                    plain manifests
    redis/                    plain manifests
  applicationsets/
    flask-applicationset.yaml
    stress-applicationset.yaml
    bonus-applicationset.yaml
```

Each ApplicationSet uses a Git directory generator. Every folder under `flask-aws-monitor/*` becomes an Argo CD Application
(`flask-aws-monitor-dev/qa/prd`) that deploys `charts/flask-aws-monitor` with that folder's `values.yaml`
into namespace `flask-<env>`. Auto sync with prune + self-heal, namespaces are created automatically.

## Environment differences

| | dev | qa | prd |
|---|---|---|---|
| replicas | 1 | 2 | 3 (HPA 3-6) |
| service | ClusterIP | NodePort | LoadBalancer + Ingress (traefik) |
| cpu req/limit | 50m / 200m | 100m / 250m | 200m / 500m |
| memory req/limit | 64Mi / 128Mi | 128Mi / 256Mi | 256Mi / 512Mi |

stress-app: dev 5% CPU load, qa 10%, prd 20% + memory worker + HPA (1-2).

## Deploy
```bash
kubectl create namespace argocd
kubectl apply -n argocd --server-side -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d; echo
kubectl -n argocd port-forward svc/argocd-server 8443:443

# AWS access comes from the builder IAM role. Outside EC2 create the secret per env:
# kubectl create secret generic aws-credentials -n flask-<env> \
#   --from-literal=AWS_ACCESS_KEY_ID=... --from-literal=AWS_SECRET_ACCESS_KEY=...

kubectl apply -n argocd -f aws/gitops/applicationsets/
kubectl get applications -n argocd
```

## Update an application
Change a `values.yaml` (replicas, tag, resources), commit, merge to `main`. Argo CD detects the change and syncs automatically.
Jenkins can bump the dev image tag (`UPDATE_GITOPS=true`), which commits to `dev`; promotion to `main` is done with a PR.
