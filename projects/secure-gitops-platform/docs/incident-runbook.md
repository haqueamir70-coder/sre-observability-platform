# Incident Runbook

## 1. Triage

1. Check deployment and pod state: `kubectl -n secure-gitops-demo get deploy,pods,svc`.
2. Inspect recent events: `kubectl -n secure-gitops-demo get events --sort-by=.lastTimestamp`.
3. Review logs: `kubectl -n secure-gitops-demo logs deploy/secure-gitops-demo --tail=100`.
4. Check probes and resource pressure: `kubectl -n secure-gitops-demo describe pod <pod-name>`.

## 2. Common failure modes

- **ImagePullBackOff:** confirm the image exists in the cluster runtime or configured registry and image pull credentials are correct.
- **CrashLoopBackOff:** inspect container logs and startup command; verify the application binds to port 8000.
- **Readiness probe failing:** check `/ready`, service target port, and NetworkPolicy rules.
- **Pods pending:** inspect resource requests, node capacity, quotas, and scheduling events.
- **HPA not scaling:** verify Metrics Server is installed and CPU requests are configured.

## 3. Safe rollback

Review rollout history, then roll back only after confirming the previous ReplicaSet is known-good:

```bash
kubectl -n secure-gitops-demo rollout history deployment/secure-gitops-demo
kubectl -n secure-gitops-demo rollout undo deployment/secure-gitops-demo
kubectl -n secure-gitops-demo rollout status deployment/secure-gitops-demo
```

Record impact, detection time, mitigation, root cause, and follow-up actions in a blameless postmortem.
