resource "null_resource" "scripts" {
  provisioner "local-exec" {
    command = <<EOF
    . ./sshConfig.sh ${aws_instance.public-EC2.public_ip} ${aws_instance.private-EC2.private_ip}
    EOF
  }
}
