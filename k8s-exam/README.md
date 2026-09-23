# K8s Workshop Exam — Shahar Cohen (`shahar`)

Manifests, Helm chart, and kubectl answers for the K8s workshop exam.

Every `yourname` placeholder is replaced with **`shahar`**.

## Layout

- `01-exam-core/` questions 1-16
- `02-pod-design/` labels, selectors, nodeSelector
- `03-deployments/` rollout, rollback, HPA
- `04-jobs/` Job with completions: 10
- `05-configmap/` config.txt + ConfigMap + pod envFrom
- `06-commands/` imperative kubectl scripts
- `chart/` Helm chart
- `apply-all.sh` apply declarative manifests
- `ANSWERS.md` question to command mapping

## Quick start

```bash
cd k8s-exam
chmod +x apply-all.sh 06-commands/*.sh
./apply-all.sh
```

## Helm

```bash
helm upgrade --install k8s-exam ./chart
```

Static pods (Q8, Q15) must be copied to `/etc/kubernetes/manifests/` on the node.
