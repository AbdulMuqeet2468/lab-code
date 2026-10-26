import RPi.GPIO as g_184
import time
import Adafruit_DHT
from bluedot import BlueDot

g_184.setmode(g_184.BCM)
g_184.setwarnings(False)

trig = 4
echo = 17
buzzer = 19

g_184.setup(trig, g_184.OUT)
g_184.setup(buzzer, g_184.OUT)
g_184.setup(echo, g_184.IN)

sensor = Adafruit_DHT.DHT11
dht_pin = 27

bd = BlueDot()

def ultrasonic():
    g_184.output(trig, False)
    time.sleep(2)
    g_184.output(trig, True)
    time.sleep(0.00001)
    g_184.output(trig, False)

    while g_184.input(echo) == 0:
        pulse_start = time.asctime()
    while g_184.input(echo) == 1:
        pulse_end = time.asctime()

    pulse_duration = pulse_end - pulse_start
    distance = pulse_duration * 17150
    distance = round(distance, 2)
    print("Distance = ", distance, "cm")

    if distance > 2 and distance < 400:
        g_184.output(buzzer, True)
        time.sleep(0.1)
        g_184.output(buzzer, False)

def dht11():
    humidity, temperature = Adafruit_DHT.read_retry(sensor, dht_pin)

    if humidity != 0 and temperature != 0:
        print("Humidity = ", humidity, "%")
        print("Temperature = ", temperature, "C")

    else:
        print("Failed to read DHT11")

def when_pressed(pos):
    if pos.x < 0:
        print("left pressed")
        print("ultrasonic measurement")
        ultrasonic()

    elif pos.x > 0:
        print("right pressed")
        print("DHT measurement")
        dht11()

bd.when_pressed = when_pressed
print("Server Started")

try:
    while True:
        time.sleep(1)
except KeyboardInterrupt:
    print("Stopped")
    g_184.cleanup()
