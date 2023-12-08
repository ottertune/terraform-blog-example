provider "aws" {
  region  = "us-east-2" # replace with your desired region
  profile = "external"
}

# export TF_VAR_db_password="your_secure_password"
variable "db_password" {}

resource "aws_db_instance" "education" {
  identifier        = "education"
  instance_class    = "db.t3.micro"
  allocated_storage = "5"
  engine            = "postgres"
  engine_version    = "14"
  username          = "edu"
  password          = var.db_password
  #db_subnet_group_name   = aws_db_subnet_group.education.name
  #vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name         = aws_db_parameter_group.education.name
  publicly_accessible          = true
  skip_final_snapshot          = true
  backup_retention_period      = "0"
  multi_az                     = false
  performance_insights_enabled = true
}
