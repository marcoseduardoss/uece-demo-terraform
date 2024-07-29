output "private_key" {
  value     = tls_private_key.wordpress_key.private_key_pem
  sensitive = true
}

output "final_snapshot_id" {
  value = aws_db_instance.meu_rds.final_snapshot_identifier
}
