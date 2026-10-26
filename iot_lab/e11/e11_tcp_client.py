import socket

SERVER_IP = "172.30.1.236"
PORT = 5000

client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client_socket.connect((SERVER_IP, PORT))

print("Connected to TCP Server")

while True:
    message = input("Enter message:")

    client_socket.send(message.encode())

    if message.lower() == "exit":
        break

    response = client_socket.recv(1024).decode()
    print("Server:", response)

client_socket.close()