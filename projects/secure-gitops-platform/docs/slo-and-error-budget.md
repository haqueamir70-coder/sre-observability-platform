# SLO and Error Budget

## Proposed service objectives

These are example objectives for the lab, not measured production results.

| Indicator | Objective | Measurement |
|---|---:|---|
| Availability | 99.9% monthly | Successful health requests / total health requests |
| Latency | 95% under 300 ms | p95 of `http_request_duration_seconds` |
| Error ratio | Below 1% over 30 days | 5xx requests / all requests |

## Error budget

For a 30-day month, 99.9% availability permits approximately 43.2 minutes of unavailability. A burn-rate alert should combine a short window for fast detection with a longer window for sustained impact.

## Operational policy

- If the error budget is healthy, continue planned releases with normal safeguards.
- If the budget is burning rapidly, prioritize reliability fixes and reduce risky changes.
- If the budget is exhausted, review release risk with service owners before proceeding.
- Never claim these objectives are achieved until real telemetry has been measured over the stated window.
