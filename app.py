"""
Containerized web service for the DevOps assignment.
Exposes a greeting endpoint and a JSON health endpoint used by container
orchestrators (Docker HEALTHCHECK, Kubernetes probes, etc.) to confirm
the service is alive.
"""

import os
from datetime import datetime, timezone

from flask import Flask, jsonify

app = Flask(__name__)

APP_PORT = int(os.getenv("PORT", 5050))


@app.route("/")
def greet():
    return "Hello Devops World!"


@app.route("/health")
def health():
    return jsonify(status="healthy", time=datetime.now(timezone.utc).isoformat())


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=APP_PORT)
