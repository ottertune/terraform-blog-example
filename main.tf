# Note: This file is for tutorial purposes. Adjust the options for production use cases, especially for security and reliability.

# Provider information
provider "aws" {
  region = "us-east-2" # replace with your desired region
}


# Set environment variable `TF_VAR_db_password="your_secure_password"`
variable "db_password" {}

import {
  to = aws_db_instance.terraform_blog_example
  id = "terraform-blog-example"
}

# AWS RDS PostgreSQL instance creation using Terraform
resource "aws_db_instance" "terraform_blog_example" {

  # Instance specifications

  identifier                   = "terraform-blog-example"                           # The unique identifier for the RDS instance
  engine                       = "postgres"                                         # The database engine
  engine_version               = "15"                                               # The version of the database engine
  instance_class               = "db.t3.micro"                                      # Determines the machine type used for the DB instance
  allocated_storage            = "10"                                               # The size of the storage (in GB) allocated to the DB instance
  username                     = "postgres"                                         # Master username for the DB instance
  password                     = var.db_password                                    # Master password for the DB instance
  parameter_group_name         = aws_db_parameter_group.terraform_blog_example.name # The DB parameter group to associate with the DB instance
  performance_insights_enabled = true                                               # Enables RDS Performance Insights for the DB instance

  # Tutorial specific settings (not recommended in production environments)

  publicly_accessible     = true  # Whether the DB instance is accessible from the internet
  backup_retention_period = "0"   # The number of days to retain backups ('0' disables backups)
  skip_final_snapshot     = true  # Whether to skip creation of final snapshot before the DB instance is deleted
  multi_az                = false # Whether to replicate the DB instance across multiple AZs for high availability

  # Optional settings

  # Uncomment and set these if you are using a custom VPC or need specific network settings
  # db_subnet_group_name = "your_db_subnet_group" # The DB subnet group name to associate with this instance
  # vpc_security_group_ids = ["sg-xxxxxxxx"]      # List of VPC security group IDs to associate with this instance

  # Add additional settings here as necessary
}


