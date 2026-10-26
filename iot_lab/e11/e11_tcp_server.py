import socket

HOST =  "0.0.0.0"
PORT = 5000

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.bind((HOST, PORT))
server_socket.listen(1)

print("TCP Server is waiting for connection...")

conn, address = server_socket.accept()
print("COnnected by:", address)

while True:
    data = conn.recv(1024)

    if not data:
        break

    message = data.decode()
    print("Client:", message)

    if message.lower() == "exit":
        break

    response = "Message received by TCP server"
    conn.send(response.encode())

conn.close()
server_socket.close()
print("TCP Server stopped")