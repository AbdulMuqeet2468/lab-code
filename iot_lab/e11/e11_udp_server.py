import socket

HOST =  "0.0.0.0"
PORT = 5001

server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
server_socket.bind((HOST, PORT))

print("UDP Server is waiting for messages...")

while True:
    data, address = server_socket.recvfrom(1024)

    message = data.decode()
    print("Client:", message)
    print("Client address:", address)

    if message.lower() == "exit":
            break
    
    response = "Message received by UDP server"
    server_socket.sendto(response.encode(), address)

server_socket.close()
print("UDP Server stopped")