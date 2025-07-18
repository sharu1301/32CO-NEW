output "ecr_repository_url" {
  value = aws_ecr_repository.nodejs_app.repository_url
}

output "rds_endpoint" {
  value = module.rds.db_instance_endpoint
}

output "cluster_name" {
  value = var.cluster_name
}

