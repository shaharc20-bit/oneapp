FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
# requirements.txt is locked with hashes (made from requirements.in by uv pip compile). Wheels only.
RUN pip install --no-cache-dir --require-hashes --only-binary :all: -r requirements.txt

COPY app.py .

RUN useradd --create-home --shell /bin/bash appuser
USER appuser

ENV PORT=5050 \
    HOST=0.0.0.0
EXPOSE 5050

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD python -c "import os,urllib.request; urllib.request.urlopen('http://localhost:' + os.environ.get('PORT','5050') + '/health')" || exit 1

CMD ["python", "app.py"]
