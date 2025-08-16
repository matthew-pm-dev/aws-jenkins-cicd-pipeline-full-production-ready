resource "aws_security_group" "nexus" {
  name        = "nexus-sg"
  description = "Nexus server security group"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Nexus Admin"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "EC2 Instance Connect SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    prefix_list_ids = [data.aws_ec2_managed_prefix_list.ec2_instance_connect.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nexus_server" {
  ami           = var.nexus_ami
  instance_type = var.nexus_instance_type
  subnet_id     = element(data.aws_subnets.default.ids, 0)

  iam_instance_profile = aws_iam_instance_profile.jenkins_ec2_profile.name
  vpc_security_group_ids = [aws_security_group.nexus.id]

  user_data = file("${path.module}/scripts/nexus-bootstrap.sh")

  tags = {
    Name = "mpm-nexus-server"
  }
}