import socket

class TestClient:
    def __init__(self, host, port):
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

        self.sock.connect(("localhost",10002))

        self.sock.sendall("go".encode("ascii"))

    def __del__(self):
        self.sock.close()

    def start(self):
        self.sock.sendall("lib=macro func=start".encode("ascii"))

    def wait(self,frames):
        self.sock.sendall(f"lib=action func=wait args={frames}".encode("ascii"))

    def finish(self):
        self.sock.sendall("all=done".encode("ascii"))