resource "aws_db_parameter_group" "education" {
  name   = "education"
  family = "postgres14"

  parameter {
    name  = "log_connections"
    value = "1"
  }
  parameter {
    name  = "autovacuum_vacuum_cost_delay"
    value = "2"
  }

}
