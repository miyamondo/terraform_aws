# create gateway
resource "aws_internet_gateway" "stg_menta_igw" {
  vpc_id = aws_vpc.stg_menta_vpc.id
  tags = {
   Name = "stg_menta_igw"
  }
}
