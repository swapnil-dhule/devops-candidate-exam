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
    response = requests.post(url, headers=headers, json=payload)
    result = {
        "StatusCode": response.status_code,
        "LogResult": base64.b64encode(response.content).decode('utf-8'),
        "ExecutedVersion": "$LATEST"
        }

    return result