# Answers keyed to the exam

`yourname` → **`shahar`**

See README.md and `06-commands/` for the full command list.

## Exam core (1-16)

1. `kubectl run nginx-pod-shahar --image=nginx:alpine` — `01-exam-core/01-nginx-pod.yaml`
2. `kubectl run messaging --image=redis:alpine --labels=tier=msg`
3. `kubectl create ns apx-x998-shahar`
4. `kubectl get nodes -o json > /tmp/nodes-shahar`
5. Imperative: `kubectl expose pod messaging --name=messaging-service --port=6379 --target-port=6379 --type=ClusterIP`
6. Declarative: `01-exam-core/05-messaging-service.yaml` (selector `tier=msg`)
7. `kubectl create deploy hr-web-app --image=kodekloud/webapp-color --replicas=2`
8. Copy `01-exam-core/08-static-busybox.yaml` to `/etc/kubernetes/manifests/` on master
9. `kubectl create ns finance-shahar && kubectl run temp-bus --image=redis:alpine -n finance-shahar`
10. PV `pv-analytics` 100Mi RWX hostPath `/pv/data-analytics`
11. Pod `redis-storage-shahar` emptyDir mount `/data/redis`
12. Pod `use-pvspec-shahar` + PV `pv-1` hostPath `/data` + PVC `pvc-1`
13. `kubectl create deploy nginx-deploy --image=nginx:1.16 --replicas=1` then `kubectl set image deploy/nginx-deploy nginx=nginx:1.17` + annotate change-cause
14. nginx-resolver + service; nslookup from busybox:1.28 into `/root/nginx-shahar.svc` and `/root/nginx-shahar.pod`
15. Copy `15-nginx-critical.yaml` to node01 `/etc/kubernetes/manifests/`
16. multi-pod: container alpha=nginx env name=alpha; beta=busybox sleep 4800 env name=beta

## ConfigMap

```bash
kubectl create configmap keyvalcfgmap --from-env-file=05-configmap/config.txt
kubectl apply -f 05-configmap/nginx-pod.yaml
kubectl exec nginx -- printenv | grep key
```
