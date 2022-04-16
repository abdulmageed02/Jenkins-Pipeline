resource "aws_instance" "pubEC2" {
  ami                         = var.AMI
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.public_key_pair.id
  vpc_security_group_ids      = [aws_security_group.SG-1.id]
  subnet_id                   = module.network.pub1_id
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 10
    delete_on_termination = true
  }

  provisioner "local-exec" {
    
      command = " echo ${self.public_ip}"
    
  }

  tags = {
    Name = "Pub-EC2"
  }
}

resource "aws_instance" "instance" {
  ami                         = var.AMI
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.public_key_pair.id
  vpc_security_group_ids      = [aws_security_group.SG-1.id]
  subnet_id                   = module.network.private2_id
  associate_public_ip_address = false

  root_block_device {
    volume_size           = 10
    delete_on_termination = true
  }

  tags = {
    Name = "Private-EC2"
  }
}