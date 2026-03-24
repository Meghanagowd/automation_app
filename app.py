from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello! Docker is running successfully.,trigger"

if __name__ == "__main__":
    # host="0.0.0.0" is essential for Docker to map ports correctly
    app.run(host="0.0.0.0", port=5000)
