#Database stack's ouput
output "db_secret_username_arn" {
    description = "ARN for Secret manager - database username"
    value = aws_secretsmanager_secret.db_master_username.arn
}

output "db_secret_password_arn" {
    description = "ARN for Secret manager - database password"
    value = aws_secretsmanager_secret.db_master_password.arn
}

output "db_db_cluster_01_arn" {
    value = aws_rds_cluster.mysql_db_cluster_01.arn
}

output "db_db_endpoint" {
    value = aws_rds_cluster.mysql_db_cluster_01.endpoint
}