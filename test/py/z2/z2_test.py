from py.testclient import TestClient

import unittest

class Z2Test(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls._client = TestClient("localhost",20202)

    @classmethod
    def tearDownClass(cls):
        cls._client.finish()
        del cls._client

    def test_thing(self):
        self._client.start()
        self._client.wait(50)
        self.assertEqual('foo'.upper(),'FOO')
        
    def test_otherthing(self):
        self._client.start()
        self._client.wait(50)
        self.assertEqual('bar'.upper(),'BAR')