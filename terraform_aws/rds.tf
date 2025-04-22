resource "aws_rds_cluster_parameter_group" "stg_menta_aurora_pg" {
  name   = "stg-menta-aurora-pg"
  family = "aurora-mysql8.0"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }
  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
  parameter {
    name  = "time_zone"
    value = "Asia/Tokyo"
  }
}

resource "aws_rds_cluster" "stg_menta_aurora_cluster" {
  cluster_identifier              = "stg-menta-aurora-cluster"
  engine                          = "aurora-mysql"
  engine_version                  = "8.0.mysql_aurora.3.08.0"
  master_username                 = jsondecode(data.aws_secretsmanager_secret_version.master_credentials.secret_string)["stg_menta_rds_user"]
  master_password                 = jsondecode(data.aws_secretsmanager_secret_version.master_credentials.secret_string)["stg_menta_rds_pw"]
  database_name                   = "wordpressdb"
  db_subnet_group_name            = aws_db_subnet_group.stg_menta_subnetgr.name
  vpc_security_group_ids          = [aws_security_group.stg_menta_rds_sg.id]
  skip_final_snapshot             = true
  storage_encrypted               = true
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.stg_menta_aurora_pg.name

  tags = {
    Name = "stg_menta_aurora_cluster"
  }
}

resource "aws_rds_cluster_instance" "stg_menta_aurora_instance" {
  count               = 2
  identifier          = "stg-menta-aurora-instance-${count.index}"
  cluster_identifier  = aws_rds_cluster.stg_menta_aurora_cluster.id
  instance_class      = var.stg_menta_rds_instanceclass
  engine              = "aurora-mysql"
  publicly_accessible = false

  tags = {
    Name = "stg_menta_aurora_instance_${count.index}"
  }
}

resource "aws_db_subnet_group" "stg_menta_subnetgr" {
  subnet_ids = [
    data.terraform_remote_state.ec2-nw.outputs.stg_menta_private-a_id,
    data.terraform_remote_state.ec2-nw.outputs.stg_menta_private-c_id
  ]

  tags = {
    Name = "stg_menta_subnetgr"
  }
}

data "aws_secretsmanager_secret" "stg_menta_rds_credentials" {
  name = "stg_menta_rds_credentials"
}

data "aws_secretsmanager_secret_version" "master_credentials" {
  secret_id = data.aws_secretsmanager_secret.stg_menta_rds_credentials.id
}
