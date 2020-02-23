import sys
from py.z2_testclient import Z2TestClient

    

if __name__ == "__main__":
    client = Z2TestClient("localhost",10002)

    client.start()
    client.wait(50)
    client.finish()

    del client