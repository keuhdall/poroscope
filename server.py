from flask import Flask
from poroscope import generateHoroscope

app = Flask(__name__)

@app.route('/horoscope/<sign>')
def horoscope(sign):
  return generateHoroscope(sign)

if __name__ == '__main__':
    app.run(port=8080)