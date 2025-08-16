#!/bin/bash
yum update -y
yum install -y docker
yum install -y aws-cli curl

sudo curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-$(uname -m) -o /usr/libexec/docker/cli-plugins/docker-compose
sudo chmod +x /usr/libexec/docker/cli-plugins/docker-compose

systemctl enable --now docker

useradd nexus
usermod -aG docker nexus

sudo -u nexus docker run -d -p 8081:8081 --name nexus -v nexus-data:/nexus-data sonatype/nexus3