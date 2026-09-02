import os

from flask import Flask, jsonify

app = Flask(__name__)


@app.get("/")
def index():
    return jsonify(
        service="aws-github-action",
        environment=os.getenv("APP_ENV", "unknown"),
        version=os.getenv("APP_VERSION", "unknown"),
        message="Service is running",
    )


@app.get("/health")
def health():
    return jsonify(status="healthy"), 200


@app.get("/ready")
def ready():
    return jsonify(status="ready"), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)