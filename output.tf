output "pubEC2" {
  value = aws_instance.public-EC2.public_ip
}


output "privEC2" {
  value = aws_instance.private-EC2.private_ip
}

output "key" {
  value = tls_private_key.private_key_pair.private_key_pem
  sensitive = true

}
