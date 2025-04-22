# Create route-table
resource "aws_route_table" "stg_menta_public-route" {
  vpc_id = aws_vpc.stg_menta_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.stg_menta_igw.id
  }
  tags = {
    Name = "stg_menta_public_route"
  }
}

resource "aws_route_table" "stg_menta_private-route" {
  vpc_id = aws_vpc.stg_menta_vpc.id

  tags = {
    Name = "stg_menta_private_route"
  }
}
