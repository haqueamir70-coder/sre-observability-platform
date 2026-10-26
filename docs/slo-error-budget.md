# SLI, SLO, and Error Budget Notes

This is an educational example, not an externally committed service-level objective.

- **Availability SLI:** successful (non-5xx) requests divided by total requests. Decide explicitly whether 4xx responses are excluded from the error numerator for your service.
- **Latency SLI:** proportion of requests completed within a chosen latency threshold.
- **SLO:** a target over a defined rolling window, such as 99.9% availability over 30 days. Select a target based on user expectations and service criticality, not by copying a number blindly.
- **Error budget:** the tolerated unreliability implied by the SLO. A 99.9% target permits 0.1% unsuccessful requests within the chosen measurement window.

Before production use, define eligible traffic, maintenance treatment, aggregation windows, alert routing, and ownership.
