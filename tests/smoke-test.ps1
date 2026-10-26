# Basic smoke test for the local SRE demo stack.
$ErrorActionPreference = "Stop"
$health = Invoke-RestMethod "http://localhost:8000/health"
if ($health.status -ne "ok") { throw "Health check failed" }
$metrics = (Invoke-WebRequest "http://localhost:8000/metrics").Content
if ($metrics -notmatch "http_requests_total") { throw "Prometheus request metric not found" }
Write-Host "PASS: API health and metrics endpoint"
