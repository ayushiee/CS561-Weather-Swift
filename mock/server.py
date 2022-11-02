from flask import Flask, jsonify
import json

app = Flask(__name__);

@app.route('/data/2.5/weather', methods=['GET'])
@app.route('/data/2.5/weather?lat=44.5646&lon=-123.262&&appid=accessKey', methods=['GET'])
def get_weather():
    f = open("weather_response.json", "r")
    return json.load(f)

@app.route('/', methods=['GET'])
def default():
    return jsonify({'response': 'Hey there'})

if __name__ == '__main__':
    app.run()
