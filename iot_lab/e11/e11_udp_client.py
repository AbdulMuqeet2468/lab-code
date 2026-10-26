import socket

SERVER_IP = "172.30.1.236"
PORT = 5001

client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)


print("UDP client started")

while True:
    message = input("Enter message:")

    client_socket.sendto(message.encode(), (SERVER_IP, PORT))

    if message.lower() == "exit":
        break

    data, address = client_socket.recvfrom(1024)
    print("Server:", data.decode())
    
client_socket.close()