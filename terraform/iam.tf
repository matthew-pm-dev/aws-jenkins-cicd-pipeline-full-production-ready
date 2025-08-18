resource "aws_iam_role" "jenkins_ec2_role" {
  name = "jenkins-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "jenkins_parameter_store_access" {
  name = "jenkins-parameter-store-access"
  description = "Jenkins server authorization to fetch admin user/pass from parameter store"
  policy = templatefile("${path.module}/iam-policy-docs/jenkins-admin-credentials-parameter-store-access.json", {
    account_id = data.aws_caller_identity.current.account_id
    region = var.region
  })
}

resource "aws_iam_role_policy_attachment" "jenkins_parameter_store_role_attach" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = aws_iam_policy.jenkins_parameter_store_access.arn
}

resource "aws_iam_role_policy_attachment" "ssm_ec2_role_attach" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "s3_readonly" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "jenkins_ec2_profile" {
  name = "jenkins-ec2-profile"
  role = aws_iam_role.jenkins_ec2_role.name
}
