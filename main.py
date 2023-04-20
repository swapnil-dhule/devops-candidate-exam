import requests
import base64

def lambda_handler(event, context):
    url = "https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data"
    headers = {"X-Siemens-Auth": "test"}
    payload = {
        "subnet_id": "10.0.250.0/24",
        "name": "Swapnil_Dhule",
        "email": "swapneel.dhule@gmail.com"
    }
    
    try:
        response = requests.post(url, headers=headers, json=payload)
        response.raise_for_status() # Raise an exception for any HTTP error status codes
        result = {
            "StatusCode": response.status_code,
            "LogResult": base64.b64encode(response.content).decode('utf-8'),
            "ExecutedVersion": "$LATEST"
        }
    except requests.exceptions.RequestException as e:
        # Handle any HTTP request exceptions and return an appropriate response
        result = {
            "StatusCode": 500,
            "LogResult": str(e),
            "ExecutedVersion": "$LATEST"
        }

    return result
