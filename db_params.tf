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
  parameter {
    name  = "autovacuum_vacuum_cost_limit"
    value = "200"
  }
  parameter {
    name  = "autovacuum_vacuum_scale_factor"
    value = "0.1"
  }
  parameter {
    name  = "autovacuum_vacuum_threshold"
    value = "50"
  }
  parameter {
    name  = "bgwriter_delay"
    value = "200"
  }
  parameter {
    name  = "bgwriter_lru_maxpages"
    value = "100"
  }
  parameter {
    name  = "bgwriter_lru_multiplier"
    value = "2"
  }
  parameter {
    name  = "checkpoint_completion_target"
    value = "0.9"
  }
  parameter {
    name  = "default_statistics_target"
    value = "100"
  }
  parameter {
    name  = "effective_cache_size"
    value = "47626"
  }
  parameter {
    name  = "effective_io_concurrency"
    value = "1"
  }
  parameter {
    name  = "max_wal_size"
    value = "2048"
  }
  parameter {
    name  = "random_page_cost"
    value = "4"
  }
  parameter {
    name  = "temp_buffers"
    value = "1024"
  }
  parameter {
    name  = "wal_writer_delay"
    value = "200"
  }
  parameter {
    name  = "work_mem"
    value = "4096"
  }

}
