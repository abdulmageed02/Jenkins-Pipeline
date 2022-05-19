# resource "null_resource" "scripts" {
#   provisioner "local-exec" {
#     command = <<EOF
#     echo '${tls_private_key.private_key_pair.private_key_pem}' > mykey.pem
# #     chmod 400 mykey.pem
#     EOF
#   }
# }
