from flask import Flask, jsonify
from sympy import isprime
import os

app = Flask(__name__)

@app.route('/is_prime/<x>', methods=['GET'])
def is_prime(x):
    if isprime(int(x)):
        return jsonify({
            "output": "true"
        })
    else:
        return jsonify({
            "output": "false"
        })


# @app.route('/getcode', methods=['GET'])
# def get_code():
#     # เปลี่ยนค่านี้ตามที่ผู้สอนกำหนด
#     code_value = os.getenv('CODE_VALUE', 'DEFAULT_CODE_12345')
#     return jsonify({
#         "code": code_value+"---55",
#         "message": "Code retrieved successfully"
        
#     })


# @app.route('/plus/<num1>/<num2>', methods=['GET'])
# def plus(num1, num2):
#     try:
#         # แปลง string เป็น int เอง
#         num1 = int(num1)
#         num2 = int(num2)
#         result = num1 + num2
#         return jsonify({
#             "num1": num1,
#             "num2": num2,
#             "result": result,
#             "operation": "addition"
#         })
#     except (ValueError, TypeError) as e:
#         return jsonify({"error": "Invalid number format"}), 400

# @app.route('/health', methods=['GET'])
# def health_check():
#     return jsonify({"status": "healthy", "message": "API is running"})

if __name__ == '__main__':
    port = int(os.getenv('PORT', 5000))
    app.run(host='0.0.0.0', port=5001, debug=False)