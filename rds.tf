resource "aws_db_instance" "meu_rds" {
  allocated_storage     = 20
  engine                = "mysql"
  engine_version        = "8.0"
  instance_class        = "db.t3.micro"
  db_name               = var.db_name
  username              = var.db_username
  password              = var.db_password
  parameter_group_name  = "default.mysql8.0"
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  skip_final_snapshot   = true
  final_snapshot_identifier = "meu-rds-snapshot-final-${formatdate("YYYYMMDDHHmmss", timestamp())}"

  tags = {
    Name = "MeuRDS"
  }
}
