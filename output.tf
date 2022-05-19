# output "pubEC2" {
#   value = aws_instance.pubEC2.public_ip
# }


# output "privateEC2" {
#   value = aws_instance.instance.private_ip
# }

output "key" {
  value = tls_private_key.private_key_pair.private_key_pem
  sensitive = true

}
