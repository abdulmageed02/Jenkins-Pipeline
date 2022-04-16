resource "aws_eip" "eip1" {
  vpc = true  
tags = {

      Name= "${var.WS}_EIP1"
  }
  
}

resource "aws_eip" "eip2" {
  vpc = true  

  tags = {

      Name= "${var.WS}_EIP2"
  }
}