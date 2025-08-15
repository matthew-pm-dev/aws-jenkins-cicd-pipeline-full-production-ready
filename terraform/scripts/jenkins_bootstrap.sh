#!/bin/bash
yum update -y
yum install -y docker docker-compose-plugin aws-cli

systemctl enable --now docker

useradd jenkins
usermod -aG docker jenkins

#${bucket_name} is injected by terraform templatefile
aws s3 cp "s3://${bucket_name}/jenkins/" "/usr/local/bin/init-scripts/" --recursive
chmod -R +x /usr/local/bin/init-scripts/

sudo -u jenkins docker compose up -d