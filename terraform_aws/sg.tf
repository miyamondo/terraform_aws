resource "aws_security_group" "stg_menta_ec2_sg" {
  name   = "stg_menta_ec2_sg"
  vpc_id = data.terraform_remote_state.ec2-nw.outputs.stg_menta_vpc_id
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.stg_menta_alb_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "stg_menta_ec2_sg"
  }
}

resource "aws_security_group" "stg_menta_alb_sg" {
  name   = "stg_menta_alb_sg"
  vpc_id = data.terraform_remote_state.ec2-nw.outputs.stg_menta_vpc_id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "stg_menta_alb_sg"
  }
}

resource "aws_security_group" "stg_menta_rds_sg" {
  name   = "stg_menta_rds_sg"
  vpc_id = data.terraform_remote_state.ec2-nw.outputs.stg_menta_vpc_id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.stg_menta_ec2_sg.id]
  }
  tags = {
    Name = "stg_menta_rds_sg"
  }
}
