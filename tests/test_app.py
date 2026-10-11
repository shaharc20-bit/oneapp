import sys, os
sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))
from app import app

client = app.test_client()

def test_home_page():
    r = client.get("/")
    assert r.status_code == 200
    assert "Service Online" in r.get_data(as_text=True)

def test_health():
    r = client.get("/health")
    assert r.status_code == 200
    assert r.get_json()["status"] == "ok"

def test_api_info():
    r = client.get("/api/info")
    assert r.status_code == 200
    assert r.get_json()["version"] == "1.0.0"
