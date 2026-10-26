import socket

HOST = "0.0.0.0"
PORT = 5000

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server_socket.bind((HOST, PORT))
server_socket.listen(1)

print("TCP DHT11 Server")
print(f"Server listening on port {PORT}")
print("waiting for client...")

try:
    conn, address = server_socket.accept()
    print("client connected:", address)

    while True:
        data = conn.recv(1024)

        if not data:
            print("client disconnected")
            break

        message = data.decode()

        if message.lower() == "exit":
            print("client requested to stop")
            break

        print("received sensor data")
        print(message)

        # send ack
        response = "TCP Server: Data received sucessfully"
        conn.send(response.encode())

except KeyboardInterrupt:
    print("\nTCP Server stopped")

finally: 
    try: 
        conn.close
    except:
        pass
    