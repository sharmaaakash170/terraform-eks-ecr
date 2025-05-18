from flask import Flask, request
from prometheus_flask_exporter import PrometheusMetrics
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST

app = Flask(__name__)

# ================= Prometheus Configs===================================================================
http_requests_total = Counter('http_requests_total', 'Total HTTP Requests', ['method', 'endpoint'])

@app.before_request
def before_request():
    http_requests_total.labels(method=request.method, endpoint=request.path).inc()
    
@app.route('/metrics')
def prometheus_metrics(): 
    return generate_latest(), 200, {'Content-Type': CONTENT_TYPE_LATEST}

# =========================================================================================================

@app.route("/")
def main():
    return "Welcome!"

@app.route('/hru')
def hello():
    return 'I am good, how about you?'

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
