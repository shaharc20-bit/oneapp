# oneapp

A small Flask application created for the DevOps container assignment. When accessed in a browser, it returns: `Hello Devops World!`

## Files

* `app.py` - the Python web application
* `requirements.txt` - Python dependencies
* `Dockerfile` - instructions for building the Docker image
* `README.md` - instructions for running the application

## Run locally

```
python -m venv .venv
```

Activate the virtual environment:

```
.venv\Scripts\Activate.ps1
```

Install the dependency and start the application:

```
pip install -r requirements.txt
python app.py
```

Open http://localhost:5000 in a browser.

## Run with Docker

Build the image:

```
docker build . -t shaharc20
```

Run the container:

```
docker run --rm -p 5000:5000 shaharc20
```

Open http://localhost:5000 in a browser.

The application listens on port `5000` by default. To use another internal port, set the `PORT` environment variable and publish the same container port:

```
docker run --rm -e PORT=8080 -p 8080:8080 shaharc20
```
