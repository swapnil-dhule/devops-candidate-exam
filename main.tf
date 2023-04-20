resource "aws_subnet" "private_subnet" {
  cidr_block        = "10.0.2.0/24"
  vpc_id            = data.aws_vpc.vpc.id
  availability_zone = "ap-south-1a"
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