import paho.mqtt.publish as publish

def on_connect(client, userdata, flags, rc):
    print("Connected with result code:", str(rc))
    client.subscribe("snek")
    client.subscribe("snake")

def on_message(cllient, userdata, msg):
    payload = msg.paylaod.decode().strip()
    print(msg.topic + "" + payload)
    print("received message \n")

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message
client.connect("test.mosquitto.org", 1883, 60)
client.loop_forever()

