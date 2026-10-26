# Incident Runbook

## 1. Triage service availability
1. Check `docker compose ps`.
2. Check API health: `Invoke-RestMethod http://localhost:8000/health`.
3. Inspect logs: `docker compose logs --tail=100 demo-api`.
4. Confirm Prometheus target status at http://localhost:9090/targets.

## 2. Investigate elevated latency
1. Inspect the p95 latency panel.
2. Compare recent request rate and latency trends.
3. Check container resource pressure and API logs.
4. Capture the incident timeline and evidence before changing the environment.

## 3. Investigate elevated 5xx ratio
1. Query `sum(rate(http_requests_total{job="demo-api",status=~"5.."}[5m]))`.
2. Compare with total request rate.
3. Use the intentionally failing route `/demo/error` to create a controlled 500 response.
4. Confirm alert state in Prometheus at http://localhost:9090/alerts.

## 4. Recovery and closure
- Verify health and target status recover.
- Record impact, root cause, contributing factors, remediation, and follow-up owners.
- Do not claim alert delivery: this lab has alert rules but no Alertmanager notification receiver configured.
