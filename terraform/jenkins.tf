resource "aws_security_group" "jenkins" {
  name        = "jenkins-sg"
  description = "Jenkins server security group"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Jenkins Admin"
    from_port   = 8080
    to_port     = 8080
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

data "template_file" "jenkins_bootstrap" {
  template = file("${path.module}/scripts/jenkins_bootstrap.sh")
}

resource "aws_instance" "jenkins_server" {
  ami           = var.jenkins_ami
  instance_type = var.jenkins_instance_type
  subnet_id              = element(data.aws_subnets.default.ids, 0)

  iam_instance_profile = aws_iam_instance_profile.ssm_ec2_profile.name
  vpc_security_group_ids = [aws_security_group.jenkins.id]

  user_data_base64 = base64encode(data.template_file.jenkins_bootstrap.rendered)

  tags = {
    Name = "mpm-jenkins-server"
  }
}