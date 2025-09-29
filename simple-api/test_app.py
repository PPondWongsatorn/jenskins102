import unittest
import json
from app import app

class TestAPI(unittest.TestCase):

    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    def true_when_x_is_17(self):
        response = self.app.get('/is_prime/17')
        self.assertEqual(response.status_code, 200)
        data = json.loads(response.data)
        self.assertEqual(data['output'], 'true')

    def false_when_x_is_36(self):
        response = self.app.get('/is_prime/36')
        self.assertEqual(response.status_code, 200)
        data = json.loads(response.data)
        self.assertEqual(data['output'], 'false')
    
    def true_when_x_is_13219(self):
        response = self.app.get('/is_prime/13219')
        self.assertEqual(response.status_code, 200)
        data = json.loads(response.data)
        self.assertEqual(data['output'], 'true')
    
    # def test_health_endpoint(self):
    #     response = self.app.get('/health')
    #     self.assertEqual(response.status_code, 200)
    #     data = json.loads(response.data)
    #     self.assertEqual(data['status'], 'healthy')
    
    # def test_plus_positive_numbers(self):
    #     response = self.app.get('/plus/5/6')
    #     self.assertEqual(response.status_code, 200)
    #     data = json.loads(response.data)
    #     self.assertEqual(data['result'], 11)
    #     self.assertEqual(data['num1'], 5)
    #     self.assertEqual(data['num2'], 6)
    
    # def test_plus_negative_numbers(self):
    #     response = self.app.get('/plus/-5/3')
    #     self.assertEqual(response.status_code, 200)
    #     data = json.loads(response.data)
    #     self.assertEqual(data['result'], -2)
    
    # def test_plus_zero(self):
    #     response = self.app.get('/plus/0/10')
    #     self.assertEqual(response.status_code, 200)
    #     data = json.loads(response.data)
    #     self.assertEqual(data['result'], 10)
    
    # def test_plus_large_numbers(self):
    #     response = self.app.get('/plus/999/1')
    #     self.assertEqual(response.status_code, 200)
    #     data = json.loads(response.data)
    #     self.assertEqual(data['result'], 1000)
    
    # def test_getcode_endpoint(self):
    #     response = self.app.get('/getcode')
    #     self.assertEqual(response.status_code, 200)
    #     data = json.loads(response.data)
    #     self.assertIn('code', data)
    #     self.assertIn('message', data)

if __name__ == '__main__':
    unittest.main()