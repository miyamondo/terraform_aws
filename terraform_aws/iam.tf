resource "aws_iam_role" "stg_menta_ec2iamrole" {
  name = "stg_menta_ec2iamrole"
  assume_role_policy = file("./stg_menta_ec2iamrole.json")
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
  role       = aws_iam_role.stg_menta_ec2iamrole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs_full_access" {
  role       = aws_iam_role.stg_menta_ec2iamrole.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role_policy_attachment" "menta_wp_offload_media_lite" {
  role       = aws_iam_role.stg_menta_ec2iamrole.name
  policy_arn = "arn:aws:iam::114785865157:policy/menta-WPOffloadMediaLite"
}

resource "aws_iam_instance_profile" "stg_menta_ec2_instance_profile" {
  name = "stg-menta-ec2-instance-profile"
  role = aws_iam_role.stg_menta_ec2iamrole.name
}
