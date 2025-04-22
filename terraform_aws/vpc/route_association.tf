# Association route-table with stg_menta_publicnw
resource "aws_route_table_association" "stg_menta_public-a" {
  subnet_id      = aws_subnet.stg_menta_public-a.id
  route_table_id = aws_route_table.stg_menta_public-route.id
}

resource "aws_route_table_association" "stg_menta_public-c" {
  subnet_id      = aws_subnet.stg_menta_public-c.id
  route_table_id = aws_route_table.stg_menta_public-route.id
}
resource "aws_route_table_association" "stg_menta_private-a" {
  subnet_id      = aws_subnet.stg_menta_private-a.id
  route_table_id = aws_route_table.stg_menta_private-route.id
}

resource "aws_route_table_association" "stg_menta_private-c" {
  subnet_id      = aws_subnet.stg_menta_private-c.id
  route_table_id = aws_route_table.stg_menta_private-route.id
}
