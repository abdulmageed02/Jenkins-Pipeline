resource "aws_nat_gateway" "NGW" {
  allocation_id = aws_eip.eip1.id
  subnet_id     = aws_subnet.pub-1.id

  tags = {
    Name = "${var.WS}_NGW"
  }
}

resource "aws_nat_gateway" "NGW2" {
  allocation_id = aws_eip.eip2.id
  subnet_id     = aws_subnet.pub-2.id

  tags = {
    Name = "${var.WS}_NGW2"
  }
}


