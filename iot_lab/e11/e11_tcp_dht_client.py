import socket
import time
import Adafruit_DHT
import RPi.GPIO as g_184

g_184.setmode(g_184.BCM)

# Configuration
SERVER_IP = "172.30.1.236"
SERVER_PORT = 5000

# dht connections
sensor = Adafruit_DHT.DHT11
pin = 17

# creating TCP socket
client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

print("TCP DHT11 CLIENT")

try:
    print("Connecting to server...")
    client_socket.connect((SERVER_IP,SERVER_PORT))

    print("Connected to TCP server")
    print("DHT11 connected to BCM GPIO17")

    while True:
        try: 
            humidity, temperature = Adafruit_DHT.read_retry(sensor, pin)

            if temperature is not None and humidity is not None:
                message = (f"Temperature: {temperature:.1f} C"
                           f"Humidity: {humidity:.1f} %")

                print("sensor data")
                print(message)

                # send data to server
                client_socket.sendall(message.encode())

                # receive ack
                response = client_socket.recv(1024)
                print("Server:", response.decode())
            else:
                print("Failed to read DHT11")

        except RuntimeError as error:
            print("DHT11 read error:", error)

        time.sleep(2)

except ConnectionRefusedError:
    print("ERROR: Could not connect to server")
    print("Check the server IP address and TCP server")

except KeyboardInterrupt:
    print("Stopping TCP client...")

finally:
    try:
        client_socket.sendall(b"exit")
    except:
        pass

    client_socket.close()
    dht_device.exit()