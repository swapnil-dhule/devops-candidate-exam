resource "aws_subnet" "private_subnet" {
  vpc_id            = data.aws_vpc.vpc.id
  availability_zone = "ap-south-1a"
  
  cidr_block = "10.0.250.0/24"
}

resource "aws_route_table" "private_route_table" {
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = data.aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_lambda_function" "lambda" {
  function_name = "lambda_function"
  role         = data.aws_iam_role.lambda.arn
  handler      = "lambda_function.lambda_handler"
  runtime      = "python3.8"
  timeout      = 10
  memory_size  = 128
  filename     = "${path.module}/lambda_function.zip"
}

# data "archive_file" "lambda" {
#   type        = "zip"
#   output_path = "${path.module}/lambda_function_new.zip"
#   source {
#     content  = <<-EOF
#         import requests
#         import base64

#         def lambda_handler(event, context):
#             url = "https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data"
#             headers = {"X-Siemens-Auth": "test"}
#             payload = {
#                 "subnet_id": "10.0.250.0/24",
#                 "name": "Swapnil_Dhule",
#                 "email": "swapneel.dhule@gmail.com"
#             }

#             response = requests.post(url, headers=headers, json=payload)

#             return {
#                 "StatusCode": response.status_code,
#                 "LogResult": base64.b64encode(response.content).decode('utf-8'),
#                 "ExecutedVersion": "$LATEST"
#             }
#     EOF
#     filename = "lambda_function.py"
#   }
# }


output "lambda_function_response" {
  value = jsonencode({
    StatusCode     = "$context.responseStatus",
    LogResult       = "$context.logStreamName",
    ExecutedVersion = "$context.functionVersion",
  })
}