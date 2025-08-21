resource "aws_iam_role" "nexus_ec2_role" {
  name = "nexus-ec2-role"

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

resource "aws_iam_role_policy_attachment" "nexus_ssm_ec2_role_attach" {
  role       = aws_iam_role.nexus_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_policy" "nexus_parameter_store_access" {
  name = "nexus-parameter-store-access"
  description = "Nexus server authorization to fetch admin user/pass from parameter store"
  policy = templatefile("${path.module}/iam-policy-docs/nexus-admin-credentials-parameter-store-access.json", {
    account_id = data.aws_caller_identity.current.account_id
    region = var.region
  })
}

resource "aws_iam_role_policy_attachment" "nexus_parameter_store_role_attach" {
  role       = aws_iam_role.nexus_ec2_role.name
  policy_arn = aws_iam_policy.nexus_parameter_store_access.arn
}

resource "aws_iam_policy" "nexus_s3_access" {
  name = "nexus-parameter-store-access"
  description = "Nexus read and write permissions to use s3 bucket as repository blob store"
  policy = file("${path.module}/iam-policy-docs/nexus-s3-access.json")
}

resource "aws_iam_instance_profile" "nexus_ec2_profile" {
  name = "nexus-ec2-profile"
  role = aws_iam_role.nexus_ec2_role.name
}
