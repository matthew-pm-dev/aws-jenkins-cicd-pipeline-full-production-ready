#!/bin/bash
yum update -y
yum install docker -y

systemctl start docker
systemctl enable docker

docker pull jenkins/jenkins:latest

useradd jenkins
usermod -aG docker jenkins

docker run -u jenkins -p 8080:8080 -p 50000:50000 -d \
-v jenkins_home:/var/jenkins_home \
-v /var/run/docker.sock:/var/run/docker.sock \
-v "$(command -v docker)":/usr/bin/docker \
jenkins/jenkins:latest
