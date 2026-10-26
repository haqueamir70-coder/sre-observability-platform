from time import perf_counter
from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse
from prometheus_client import Counter, Histogram, make_asgi_app

app = FastAPI(title="SRE Demo API", version="1.0.0")

REQUESTS = Counter(
    "http_requests_total",
    "Total HTTP requests handled by the API",
    ["method", "route", "status"],
)
LATENCY = Histogram(
    "http_request_duration_seconds",
    "HTTP request duration in seconds",
    ["method", "route"],
    buckets=(0.005, 0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 1.0, 2.5, 5.0),
)

@app.middleware("http")
async def observe_requests(request: Request, call_next):
    start = perf_counter()
    response = await call_next(request)
    elapsed = perf_counter() - start
    route = request.scope.get("route")
    route_label = getattr(route, "path", None) or request.url.path
    status = str(response.status_code)
    REQUESTS.labels(request.method, route_label, status).inc()
    LATENCY.labels(request.method, route_label).observe(elapsed)
    return response

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/")
def root():
    return {"service": "sre-demo-api", "status": "ok", "docs": "/docs", "metrics": "/metrics"}

@app.get("/demo/slow")
def slow_demo():
    from time import sleep
    sleep(0.15)
    return {"status": "slow-demo-complete"}

@app.get("/demo/error")
def error_demo():
    return JSONResponse(status_code=500, content={"detail": "Intentional demo server error"})

app.mount("/metrics", make_asgi_app())
