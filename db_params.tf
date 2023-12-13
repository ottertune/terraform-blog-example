# AWS RDS PostgreSQL Parameter Group Configuration

import {
  to = aws_db_parameter_group.terraform_blog_example
  id = "terraform-blog-example-pg"
}

resource "aws_db_parameter_group" "terraform_blog_example" {
  name   = "terraform-blog-example-pg" # Name of the DB parameter group
  family = "postgres15"                # Database family (PostgreSQL 15.x in this case)

  # Below are OtterTune's recommended knobs for tuning RDS PostgreSQL 15 performance.
  # They are initially set to their default values when the RDS instance is created.
  # After completing the steps in the blog article, these DB parameter group settings
  # will be updated daily with OtterTune's latest knob recommendations.

  parameter {
    name  = "autovacuum_vacuum_cost_delay"
    value = "7"
  }
  parameter {
    name  = "autovacuum_vacuum_scale_factor"
    value = "0.12"
  }
  parameter {
    name  = "autovacuum_vacuum_threshold"
    value = "439"
  }
  parameter {
    name  = "bgwriter_delay"
    value = "90"
  }
  parameter {
    name  = "bgwriter_lru_maxpages"
    value = "442"
  }
  parameter {
    name  = "bgwriter_lru_multiplier"
    value = "2.89"
  }
  parameter {
    name  = "checkpoint_completion_target"
    value = "0.81"
  }
  parameter {
    name  = "default_statistics_target"
    value = "762"
  }
  parameter {
    name  = "effective_cache_size"
    value = "53043"
  }
  parameter {
    name  = "effective_io_concurrency"
    value = "213"
  }
  parameter {
    name  = "max_wal_size"
    value = "2410"
  }
  parameter {
    name  = "random_page_cost"
    value = "1.6"
  }
  parameter {
    name  = "temp_buffers"
    value = "2452"
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