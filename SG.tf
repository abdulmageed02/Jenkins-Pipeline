resource "aws_security_group" "SG-1" {
  name        = "SSH-SG"
  description = "Allow SSH"
  vpc_id      = module.network.vpc_id

  ingress {
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.region}-SG-1"
  }
}

resource "aws_security_group" "SG-2" {
  name        = "SSH&3000"
  description = "Allow SSH & p 3000"
  vpc_id      = module.network.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [module.network.vpc_cidr]

  }

  ingress {
    description = "p3000"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [module.network.vpc_cidr]

  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.region}-SG-2"
  }
}

resource "aws_security_group" "DB-test" {
  name        = "DB-SG"
  description = "DB"
  vpc_id      = module.network.vpc_id

  ingress {
    description      = "Allow all"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [module.network.vpc_cidr]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.region}-SG-DB"
  }
}