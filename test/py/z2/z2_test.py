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
        self._client.press("....S......")
        self._client.wait(1)
        state = self._client.get_byte(0x0202F8E1)
        self.assertEqual(state,b'3')
        
    def test_otherthing(self):
        self._client.start()
        self._client.wait(50)
        self._client.press("....S......")
        self._client.wait(1)
        self.assertEqual('bar'.upper(),'BAR')