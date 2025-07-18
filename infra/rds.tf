module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 5.0"

  identifier = "nodejs-app-db"

  engine               = "postgres"
  engine_version       = "14.5"
  family               = "postgres14"   # ADD THIS LINE
  instance_class       = "db.t3.micro"
  allocated_storage    = 20

  db_name  = "nodejs_prod"
  username = "admin"
  password = var.rds_password

  # Security
  vpc_security_group_ids = [module.eks.cluster_primary_security_group_id]
  subnet_ids             = module.vpc.private_subnets
  publicly_accessible    = false

  # Maintenance
  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
  backup_retention_period = 7

  # Monitoring
  performance_insights_enabled = true

  tags = {
    Name = "nodejs-app-database"
  }
}
