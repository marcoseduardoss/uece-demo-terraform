
output "final_snapshot_id" {
  value = aws_db_instance.meu_rds.final_snapshot_identifier
}

output "load_balance_dns_name" {
  value = aws_elb.web.dns_name
}