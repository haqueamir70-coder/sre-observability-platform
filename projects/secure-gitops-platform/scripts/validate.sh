#!/usr/bin/env sh
set -eu

docker build -t secure-gitops-demo:local .
docker run --rm -d --name secure-gitops-smoke -p 18000:8000 secure-gitops-demo:local
cleanup() {
  docker rm -f secure-gitops-smoke >/dev/null 2>&1 || true
}
trap cleanup EXIT INT TERM

attempt=0
until curl --fail --silent http://localhost:18000/health >/dev/null; do
  attempt=$((attempt + 1))
  if [ "$attempt" -ge 20 ]; then
    echo "Health check failed"
    docker logs secure-gitops-smoke
    exit 1
  fi
  sleep 1
done

curl --fail --silent http://localhost:18000/ready
printf '\nSmoke test passed.\n'
