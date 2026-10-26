#!/usr/bin/env sh
set -eu
BASE_URL="${BASE_URL:-http://localhost:8000}"
curl --fail --silent --show-error "$BASE_URL/health"
curl --fail --silent --show-error "$BASE_URL/ready"
curl --fail --silent --show-error "$BASE_URL/metrics" | grep -q 'http_requests_total'
echo "Smoke tests passed."
