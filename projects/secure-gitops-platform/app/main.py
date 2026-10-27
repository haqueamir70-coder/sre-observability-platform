import time
from fastapi import FastAPI, Response
from prometheus_client import CONTENT_TYPE_LATEST, Counter, Histogram, generate_latest

app = FastAPI(title="Secure GitOps Demo API", version="1.0.0")
REQUESTS = Counter("http_requests_total", "HTTP requests", ["method", "path", "status"])
LATENCY = Histogram("http_request_duration_seconds", "HTTP request duration", ["path"])

@app.middleware("http")
async def instrument(request, call_next):
    started = time.perf_counter()
    response = await call_next(request)
    path = request.url.path
    REQUESTS.labels(request.method, path, str(response.status_code)).inc()
    LATENCY.labels(path).observe(time.perf_counter() - started)
    return response

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/ready")
def ready():
    return {"status": "ready"}

@app.get("/")
def root():
    return {"service": "secure-gitops-demo", "version": "1.0.0"}

@app.get("/metrics", include_in_schema=False)
def metrics():
    return Response(generate_latest(), media_type=CONTENT_TYPE_LATEST)
