from flask import Flask, jsonify
from app_config import APP_ENV, APP_VERSION

app = Flask(__name__)

@app.route("/health", methods=["GET"])
def health_check():
    return jsonify({"status": "healthy"})

@app.route("/", methods=["GET"])
def indexk():
    return jsonify({"environment": APP_ENV, "VERSION": APP_VERSION})


#if __name__='__manin__'    # kept pending
 #   app.run=(degug=True)




if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
