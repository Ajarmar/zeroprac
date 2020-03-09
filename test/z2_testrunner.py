import sys
import unittest
from py.z2.z2_test import Z2Test

    

if __name__ == "__main__":
    loader = unittest.TestLoader()
    suite = loader.loadTestsFromTestCase(Z2Test)
    unittest.TextTestRunner(verbosity=2).run(suite)