# Updated RDS Instance Module
module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 5.0"

  identifier             = "nodejs-app-db"
  engine                 = "postgres"
  engine_version         = "13.21"
  major_engine_version   = "13"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "nodejs_prod"
  username               = "dbadmin"
  password               = var.rds_password

  # Use custom parameter group
  parameter_group_name       = aws_db_parameter_group.nodejs_db.name
  create_db_parameter_group  = false

  # ✅ Use the correct security group in the same VPC
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  
  # ✅ Ensure subnet group is in the same VPC
  subnet_ids             = module.vpc.private_subnets
  create_db_subnet_group = true  # Let the module create the subnet group
  
  publicly_accessible    = false

  # Maintenance
  maintenance_window          = "Mon:00:00-Mon:03:00"
  backup_window               = "03:00-06:00"
  backup_retention_period     = 7
  skip_final_snapshot         = true

  # Monitoring
  performance_insights_enabled = true

  tags = {
    Name = "nodejs-app-database"
  }
}

