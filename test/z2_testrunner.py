import sys
import unittest
from py.z2_testclient import Z2TestClient

    

if __name__ == "__main__":
    loader = unittest.TestLoader()
    suite = loader.loadTestsFromTestCase(Z2TestClient)
    unittest.TextTestRunner(verbosity=2).run(suite)