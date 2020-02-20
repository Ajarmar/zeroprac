import socket

client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

client.connect(("localhost",10002))

client.sendall(b'tjosan')

client.sendall(b'lib=util func=z2_start')

client.sendall(b'lib=util func=wait args=50')

client.sendall(b'all=done')

client.close()