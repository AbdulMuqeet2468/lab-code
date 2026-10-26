import RPi.GPIO as g_184
import time
import Adafruit_DHT
from bluedot import BlueDot
from signal import pause

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

servo_pin = 18
g_184.setup(servo_pin, g_184.OUT)
servo = g_184.PWM(servo_pin, 50)
servo.start(0)

ldr_pin = 26
g_184.setup(ldr_pin, g_184.IN)


def ultrasonic():
    print("ultrasonic selected")
    g_184.output(trig, False)
    time.sleep(0.2)
    g_184.output(trig, True)
    time.sleep(0.00001)
    g_184.output(trig, False)

    timeout = time.time() + 0.1

    while g_184.input(echo) == 0:
        if time.time() > timeout:
            print("Ultrasonic echo not rx")
            return
        pulse_start = time.asctime()

    timeout = time.time() + 0.1

    while g_184.input(echo) == 1:
        if time.time() > timeout:
            print("ultrasonic not detected")
            return
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
    print("DHT Selected")
    humidity, temperature = Adafruit_DHT.read_retry(sensor, dht_pin)

    if humidity is not None and temperature is not None:
        print("Humidity = ", humidity, "%")
        print("Temperature = ", temperature, "C")

    else:
        print("Failed to read DHT11")

def servo_control():
    print("Servo selected")
    servo.ChangeDutyCycle(2.5)
    time.sleep(1)
    servo.ChangeDutyCycle(7.5)
    time.sleep(1)
    servo.ChangeDutyCycle(12.5)
    time.sleep(1)
    servo.ChangeDutyCycle(0)
    print("Servo operation completed")

def ldr():
    print("LDR selected")
    value = g_184.input(ldr_pin)
    print("LDR value =", value)

    if value == 1:
        print("light detected")
    else:
        print("DARK")

bd = BlueDot(col=2, row=2)
bd[0,0].when_pressed = ultrasonic
bd[0,1].when_pressed = dht11
bd[1,0].when_pressed = servo_control
bd[1,1].when_pressed = ldr

print("Server Started")
print("top left = ultrasonnic")
print("top right = DHT11")
print("bottom left = Servo")
print("bottom right = LDR")

try:
    pause
except KeyboardInterrupt:
    print("Stopped")
    servo.stop()
    g_184.cleanup()
