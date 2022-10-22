from flask import Flask, jsonify
from weather_response import response

app = Flask(__name__);

@app.route('/data/2.5/weather', methods=['GET'])
@app.route('/data/2.5/weather?lat=44.5646&lon=-123.262&&appid=accessKey', methods=['GET'])
def get_weather(): 
    return jsonify(response)

@app.route('/', methods=['GET'])
def default():
    return jsonify({'response': 'Hey there' })

if __name__ == '__main__':
    app.run()
