from flask import Flask
import paho.mqtt.client as mqtt

app = Flask(__name__)

@app.route("/")
def hello():
    return "Coucou rémi!"

if __name__ == "__main__":
    app.run(debug=True)