from flask import Flask, render_template_string
from datetime import datetime, timezone
import os

app = Flask(__name__)
APP_NAME = os.environ.get("APP_NAME", "OneApp")

HOME_TEMPLATE = """
<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>{{ app_name }}</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            text-align: center;
        }
        .card {
            background: rgba(255,255,255,0.15);
            padding: 40px 60px;
            border-radius: 16px;
            backdrop-filter: blur(10px);
        }
        h1 { font-size: 3rem; margin-bottom: 0.5rem; }
        p { font-size: 1.2rem; opacity: 0.9; }
    </style>
</head>
<body>
    <div class="card">
        <h1>🚀 {{ app_name }}</h1>
        <p>שלום! השירות רץ בהצלחה על Kubernetes</p>
        <p>{{ time }}</p>
    </div>
</body>
</html>
"""

@app.route("/")
def home():
    return render_template_string(HOME_TEMPLATE, app_name=APP_NAME, time=datetime.now(timezone.utc).isoformat())

@app.route("/health")
def health():
    return {"status": "ok", "time": datetime.now(timezone.utc).isoformat()}

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5050))
    app.run(host="0.0.0.0", port=port)
