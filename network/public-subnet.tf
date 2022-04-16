resource "aws_subnet" "pub-1" {
  vpc_id     = aws_vpc.Terraform-lab1.id
  cidr_block = var.pub1_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.WS}_pub-1"
  }
}   

resource "aws_subnet" "pub-2" {
  vpc_id     = aws_vpc.Terraform-lab1.id
  cidr_block = var.pub2_cidr
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.WS}_pub-2"
  }
}  