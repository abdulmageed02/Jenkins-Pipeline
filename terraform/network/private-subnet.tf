resource "aws_subnet" "private-1" {
  vpc_id     = aws_vpc.Terraform-lab1.id
  cidr_block = var.priv1_cidr
  availability_zone = "${var.region}a"
  tags = {
    Name = "${var.WS}_private-1"
  }
}

resource "aws_subnet" "private-2" {
  vpc_id     = aws_vpc.Terraform-lab1.id
  cidr_block = var.priv2_cidr
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.WS}_private-2"
  }
}  
