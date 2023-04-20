import http.client
import json
import base64

def lambda_handler(event, context):
    url = "/candidate-email_serverless_lambda_stage/data"
    headers = {"X-Siemens-Auth": "test"}
    payload = {
        "subnet_id": "10.0.250.0/24",
        "name": "Swapnil_Dhule",
        "email": "swapneel.dhule@gmail.com"
    }
    
    try:
        conn = http.client.HTTPSConnection("ij92qpvpma.execute-api.eu-west-1.amazonaws.com")
        conn.request("POST", url, json.dumps(payload), headers=headers)
        response = conn.getresponse()
        result = {
            "StatusCode": response.status,
            "LogResult": base64.b64encode(response.read()).decode('utf-8'),
            "ExecutedVersion": "$LATEST"
        }
        conn.close()
    except Exception as e:
        result = {
            "StatusCode": 500,
            "LogResult": str(e),
            "ExecutedVersion": "$LATEST"
        }

    return result