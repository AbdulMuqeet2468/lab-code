import paho.mqtt.publish as publish
import Adafruit_DHT
import time
import RPi.GPIO as g_184

g_184.setmode(g_184.BCM)
g_184.setwarnings(False)

sensor = Adafruit_DHT.DHT11
pin = 17
publish.single("snek", "184 this is a snek", hostname="test.mosquitto.org")
publish.single("snek", "184 in IoT Lab", hostname="test.mosquitto.org")

try:
    while(1):
        humidity, temperature = Adafruit_DHT.read_retry(sensor, pin)
        print(str(time.asctime()) + "184 Humidity=" + str(humidity))
        print(str(time.asctime()) + "184 Temperature=" + str(temperature))

        payload_hum = f"humidity: {humidity}"
        payload_temp = f"temperature: {temperature}"

        publish.single("snek", payload=payload_hum, hostname="test.mosquitto.org")
        publish.single("snek", payload=payload_temp, hostname="test.mosquitto.org")

        time.sleep(1)

except KeyboardInterrupt:
    print("Stopped")
    g_184.cleanup()

print("done")