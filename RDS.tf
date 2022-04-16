

resource "aws_db_subnet_group" "GG" {
  name       = "subnet-group"
  subnet_ids = [module.network.private1_id,module.network.private2_id]
}

resource "aws_db_instance" "rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name                 = "mydb"
  username             = var.db_User
  password             = var.db_Pass  # ---> should be variable
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
db_subnet_group_name    = aws_db_subnet_group.GG.name
vpc_security_group_ids = [aws_security_group.DB-test.id]
}


# mysql -u hossam -h terraform-20220416141725394600000001.cwafwsygys25.eu-central-1.rds.amazonaws.com -p202997hH7
