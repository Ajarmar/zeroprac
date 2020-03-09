import socket

class TestClient:
    def __init__(self, host, port):
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        #self.sock.settimeout(1.0)

        self.sock.connect((host,port))

        self.sock.sendall("all=go".encode("ascii"))
        ret = self.sock.recv(128)
        print(ret)

    def __del__(self):
        self.sock.close()

    def start(self):
        self.sock.sendall("lib=macro func=start".encode("ascii"))

    def press(self,buttons):
        self.sock.sendall(f"lib=action func=press args={buttons}".encode("ascii"))

    def wait(self,frames):
        self.sock.sendall(f"lib=action func=wait args={frames}".encode("ascii"))

    def get_byte(self,address):
        self.sock.sendall(f"lib=get_action func=get_byte args={address}".encode("ascii"))
        return self.sock.recv(128)

    def finish(self):
        self.sock.sendall("all=done".encode("ascii"))