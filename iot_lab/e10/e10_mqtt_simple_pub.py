import paho.mqtt.publish as publish

publish.single("snek", "184 this is snek", hostname="test.mosquitto.org")
publish.single("snek", "184 in IoT Lab", hostname="test.mosquitto.org")

publish.single("snake", "184 different channel", hostname="test.mosquitto.org")
publish.single("snake", "184 snack", hostname="test.mosquitto.org")

print("done")