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

# resource "aws_security_group" "lambda_security_group" {
#   name_prefix = "lambda_security_group"
#   vpc_id      = data.aws_vpc.vpc.id

#   ingress {
#     from_port   = 0
#     to_port     = 65535
#     protocol    = "tcp"
#     cidr_blocks = ["10.0.250.0/24"]
#   }
# }


resource "aws_lambda_function" "lambda" {
  function_name = "lambda_function"
  handler = "lambda_function.lambda_handler"
  runtime = "python3.8"
  role = data.aws_iam_role.lambda.arn
  filename = "lambda_function.zip"

#   vpc_config {
#     subnet_ids = [aws_subnet.private_subnet.id]
#     security_group_ids = [aws_security_group.lambda_security_group.id]
#   }
}
