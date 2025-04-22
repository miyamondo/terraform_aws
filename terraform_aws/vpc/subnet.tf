# Subnet
## public nw
resource "aws_subnet" "stg_menta_public-a" {
  vpc_id     = aws_vpc.stg_menta_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "stg_menta_public-a"
  }
}

resource "aws_subnet" "stg_menta_public-c" {
  vpc_id     = aws_vpc.stg_menta_vpc.id
  cidr_block = "10.0.101.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "stg_menta_public-c"
  }
}

## pvivate nw
resource "aws_subnet" "stg_menta_private-a" {
  vpc_id     = aws_vpc.stg_menta_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "stg_menta_privat-a"
  }
}

resource "aws_subnet" "stg_menta_private-c" {
  vpc_id     = aws_vpc.stg_menta_vpc.id
  cidr_block = "10.0.102.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "stg_menta_privat-c"
  }
}
