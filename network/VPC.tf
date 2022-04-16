resource "aws_vpc" "Terraform-lab1" {
  cidr_block       = var.vpc_cidr
 
  tags = {
    Name = var.vpc_name
  }
  enable_dns_hostnames = "true"
}