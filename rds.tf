resource "aws_db_instance" "meu_rds" {
  allocated_storage     = 20
  engine                = "mysql"
  engine_version        = "8.0"
  instance_class        = "db.t3.micro"
  db_name               = "MeuMysql" 
  username              = "admin"
  password              = "MinhaSenhaSegura123"
  parameter_group_name  = "default.mysql8.0"
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  skip_final_snapshot   = true// Medar p/ false garante que o snapshot seja criado antes da deleção
  final_snapshot_identifier = "meu-rds-snapshot-final-${formatdate("YYYYMMDDHHmmss", timestamp())}"

  tags = {
    Name = "MeuRDS"
  }
}


#VPC: vpc-f8709985 

#Availability Zones:
#subnet-db701c96 us-east-1a (use1-az4)
#subnet-e4df06bb us-east-1b (use1-az6)
