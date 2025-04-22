## output vpc
output "stg_menta_vpc_id" {
  value = aws_vpc.stg_menta_vpc.id
}
# output subnet id
output "stg_menta_public-a_id" {
  value = aws_subnet.stg_menta_public-a.id
}

output "stg_menta_public-c_id" {
  value = aws_subnet.stg_menta_public-c.id
}

output "stg_menta_private-a_id" {
  value = aws_subnet.stg_menta_private-a.id
}

output "stg_menta_private-c_id" {
  value = aws_subnet.stg_menta_private-c.id
}
