resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.Terraform-lab1.id

  tags = {
    Name = "${var.WS}_IGW"
  }
}