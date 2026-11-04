# End-to-End DevOps Final Exam - Flask AWS Monitor

Flask app that lists EC2 instances, VPCs, Load Balancers and AMIs, built and deployed with Terraform, Docker, Jenkins, Azure DevOps, Kubernetes, Helm and Argo CD.

## Structure
| Folder | Content |
|---|---|
| `app/` | Flask app, multi-stage Dockerfile, tests |
| `terraform/` | builder EC2, SSH key, security group, Docker install (remote-exec) |
| `cicd/` | Jenkinsfile, Jenkinsfile.shared-lib, azure-pipelines.yml |
| `jenkins/` | Jenkins on the builder (docker compose) |
| `k8s/` | Deployment + Service manifests |
| `helm/` | Helm chart `flask-aws-monitor` |
| `gitops/` | Argo CD ApplicationSets, dev/qa/prd values, bonus apps |
| `shared-library/` | Jenkins shared library (`vars/`) |
| `docs/screenshots/` | evidence |

Each folder has its own README with what was implemented and how to run it.

## Git flow
- `main` <- `dev` <- `feature/*`
- Every section was developed in its own feature branch and merged into `dev`
- `dev` is merged into `main` with a pull request only, every merge into `main` is tagged (`v1.0.0`, ...)

## Status
| Section | Status |
|---|---|
| 1 Git flow | done |
| 3 Dockerize app (multi-stage) | done |
| 4 Bug fix | done |
| Terraform (EC2, key, SG, outputs) | done |
| Terraform remote-exec Docker install (bonus) | done |
| 5 Jenkins (parallel lint + security, build, push) | done, real tools (mock mode available with `MOCK_CHECKS`) |
| 5.1 Azure DevOps (bonus) | done |
| 7 Kubernetes manifests | done |
| Helm chart + ingress (bonus) + HPA | done |
| 8 Argo CD ApplicationSet dev/qa/prd + bonus apps | done |
| Shared library (optional) | done |
