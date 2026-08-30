from flask import Flask, render_template_string, jsonify
from datetime import datetime, timezone
import os
import platform
import socket
import time

app = Flask(__name__)

APP_NAME = os.environ.get("APP_NAME", "OneApp")
APP_VERSION = os.environ.get("APP_VERSION", "1.0.0")
START_TIME = time.time()

def get_uptime():
    seconds = int(time.time() - START_TIME)
    hours, remainder = divmod(seconds, 3600)
    minutes, seconds = divmod(remainder, 60)
    return f"{hours}h {minutes}m {seconds}s"

HOME_TEMPLATE = """
<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{{ app_name }}</title>
<style>
  :root {
    --bg1: #0f0c29;
    --bg2: #302b63;
    --bg3: #24243e;
    --accent: #00d4ff;
    --accent2: #7b2ff7;
    --card-bg: rgba(255,255,255,0.06);
    --border: rgba(255,255,255,0.12);
  }
  * { box-sizing: border-box; }
  body {
    margin: 0;
    min-height: 100vh;
    font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
    background: linear-gradient(135deg, var(--bg1), var(--bg2), var(--bg3));
    background-size: 400% 400%;
    animation: gradientShift 15s ease infinite;
    color: #f0f0f5;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 24px;
  }
  @keyframes gradientShift {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
  }
  .wrap { width: 100%; max-width: 720px; }
  .badge {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 6px 14px;
    border-radius: 999px;
    background: var(--card-bg);
    border: 1px solid var(--border);
    font-size: 0.85rem;
    margin-bottom: 20px;
  }
  .dot {
    width: 8px; height: 8px; border-radius: 50%;
    background: #35e08a;
    box-shadow: 0 0 8px #35e08a;
  }
  h1 {
    font-size: clamp(2rem, 5vw, 3.2rem);
    margin: 0 0 8px;
    background: linear-gradient(90deg, var(--accent), var(--accent2));
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
  }
  .subtitle { color: #b8b8c8; margin-bottom: 32px; font-size: 1.05rem; }
  .grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 16px;
  }
  .card {
    background: var(--card-bg);
    border: 1px solid var(--border);
    border-radius: 14px;
    padding: 18px 20px;
    backdrop-filter: blur(12px);
  }
  .card .label {
    font-size: 0.75rem;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    color: #9d9db0;
    margin-bottom: 6px;
  }
  .card .value {
    font-size: 1.15rem;
    font-weight: 600;
    word-break: break-all;
  }
  footer {
    margin-top: 28px;
    font-size: 0.8rem;
    color: #7d7d90;
    text-align: center;
  }
</style>
</head>
<body>
  <div class="wrap">
    <span class="badge"><span class="dot"></span> Service Online</span>
    <h1>🚀 {{ app_name }}</h1>
    <p class="subtitle">שירות Flask שרץ בקונטיינר, פרוס דרך Kubernetes באמצעות Helm</p>
    <div class="grid">
      <div class="card">
        <div class="label">Pod / Host</div>
        <div class="value">{{ hostname }}</div>
      </div>
      <div class="card">
        <div class="label">Version</div>
        <div class="value">v{{ version }}</div>
      </div>
      <div class="card">
        <div class="label">Uptime</div>
        <div class="value">{{ uptime }}</div>
      </div>
      <div class="card">
        <div class="label">Python</div>
        <div class="value">{{ python_version }}</div>
      </div>
      <div class="card">
        <div class="label">Server Time (UTC)</div>
        <div class="value">{{ time }}</div>
      </div>
      <div class="card">
        <div class="label">Health Check</div>
        <div class="value"><a href="/health" style="color:var(--accent)">/health →</a></div>
      </div>
    </div>
    <footer>רענן את הדף כמה פעמים - אם יש כמה replicas, תראה את שם ה-Pod מתחלף</footer>
  </div>
</body>
</html>
"""

@app.route("/")
def home():
    return render_template_string(
        HOME_TEMPLATE,
        app_name=APP_NAME,
        version=APP_VERSION,
        hostname=socket.gethostname(),
        uptime=get_uptime(),
        python_version=platform.python_version(),
        time=datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S")
    )

@app.route("/health")
def health():
    return jsonify(status="ok", time=datetime.now(timezone.utc).isoformat())

@app.route("/api/info")
def info():
    return jsonify(
        app=APP_NAME,
        version=APP_VERSION,
        hostname=socket.gethostname(),
        uptime=get_uptime(),
        python_version=platform.python_version(),
    )

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5050))
    app.run(host="0.0.0.0", port=port)
