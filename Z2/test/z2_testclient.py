import socket

client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

client.connect(("localhost",10002))

client.sendall(b'go')

client.sendall(b'lib=macro func=start')

client.sendall(b'lib=action func=wait args=50')

client.sendall(b'all=done')

client.close()