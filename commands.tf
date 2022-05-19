resource "null_resource" "scripts" {
  provisioner "local-exec" {
    command = "echo ${tls_private_key.private_key_pair} > mykey.pem"
  }
}
