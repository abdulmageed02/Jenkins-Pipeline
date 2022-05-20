resource "aws_route_table" "RT-private" {
  vpc_id = aws_vpc.Terraform-lab1.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NGW.id
  }

  tags = {
    Name = "${var.WS}_RT-private-1"
  }
}

resource "aws_route_table_association" "assc-private-1" {
  subnet_id      = aws_subnet.private-1.id
  route_table_id = aws_route_table.RT-private.id
}






resource "aws_route_table" "RT-private-2" {
  vpc_id = aws_vpc.Terraform-lab1.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NGW2.id
  }

  tags = {
    Name = "${var.WS}_RT-private-2"
  }
}

resource "aws_route_table_association" "assc-private-2" {
  subnet_id      = aws_subnet.private-2.id
  route_table_id = aws_route_table.RT-private-2.id
}
