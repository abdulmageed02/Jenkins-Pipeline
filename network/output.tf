output "pub1_id" {
  value       = aws_subnet.pub-1.id
}

output "pub2_id" {
  value       = aws_subnet.pub-2.id
}

output "private1_id" {

  value       = aws_subnet.private-1.id
}

output "private2_id" {

  value       = aws_subnet.private-2.id
}


output "vpc_id" {   
  value       = aws_vpc.Terraform-lab1.id

}


output "vpc_cidr" {

  value       = aws_vpc.Terraform-lab1.cidr_block
}
