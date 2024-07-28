
output "final_snapshot_id" {
  value = aws_db_instance.meu_rds.final_snapshot_identifier
}