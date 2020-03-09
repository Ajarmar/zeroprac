import socket

class TestClient:
    def __init__(self, host, port):
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.sock.settimeout(1.0)

        self.sock.connect((host,port))

        self.sock.sendall("all=go".encode("ascii"))
        ret = self.sock.recv(128)
        print(ret)

    def __del__(self):
        self.sock.close()

    def start(self):
        self.sock.sendall("lib=macro func=start".encode("ascii"))

    def wait(self,frames):
        self.sock.sendall(f"lib=action func=wait args={frames}".encode("ascii"))

    def finish(self):
        self.sock.sendall("all=done".encode("ascii"))