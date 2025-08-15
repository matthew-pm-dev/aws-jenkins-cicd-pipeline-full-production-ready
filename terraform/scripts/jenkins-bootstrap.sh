#!/bin/bash
yum update -y
yum install -y docker
yum install -y aws-cli curl

sudo curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-$(uname -m) -o /usr/libexec/docker/cli-plugins/docker-compose
sudo chmod +x /usr/libexec/docker/cli-plugins/docker-compose

systemctl enable --now docker

useradd jenkins
usermod -aG docker jenkins

mkdir -p /opt/jenkins/scripts
chown -R jenkins:jenkins /opt/jenkins
aws s3 cp "s3://${bucket_name}/jenkins/" "/opt/jenkins/" --recursive
chmod -R +x /opt/jenkins/scripts/

cd /opt/jenkins
sudo -u jenkins docker compose up -d