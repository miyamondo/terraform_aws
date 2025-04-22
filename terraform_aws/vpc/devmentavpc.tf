# VPC
resource "aws_vpc" "stg_menta_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "stg_menta_vpc"
  }
}
