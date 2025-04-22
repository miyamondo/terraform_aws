resource "aws_eip" "stg_menta_app01_ip" {
  instance = aws_instance.stg_menta_app01.id
  tags = {
    Name = "stg_menta_app01_ip"
  }
}
resource "aws_eip" "stg_menta_app02_ip" {
  instance = aws_instance.stg_menta_app02.id
  tags = {
    Name = "stg_menta_app02_ip"
  }
}

resource "aws_instance" "stg_menta_app01" {
  ami                    = var.stg_menta_ami_id
  instance_type          = var.stg_menta_instance_type
  subnet_id              = data.terraform_remote_state.ec2-nw.outputs.stg_menta_public-a_id
  iam_instance_profile   = aws_iam_instance_profile.stg_menta_ec2_instance_profile.name
  vpc_security_group_ids = [aws_security_group.stg_menta_ec2_sg.id]

  tags = {
    Name = "stg_menta_app01"
  }
}
resource "aws_instance" "stg_menta_app02" {
  ami                    = var.stg_menta_ami_id
  instance_type          = var.stg_menta_instance_type
  subnet_id              = data.terraform_remote_state.ec2-nw.outputs.stg_menta_public-c_id
  iam_instance_profile   = aws_iam_instance_profile.stg_menta_ec2_instance_profile.name
  vpc_security_group_ids = [aws_security_group.stg_menta_ec2_sg.id]

  tags = {
    Name = "stg_menta_app02"
  }
}
