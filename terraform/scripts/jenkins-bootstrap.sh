#!/bin/bash
yum update -y
yum install -y docker
yum install -y aws-cli curl

sudo curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-$(uname -m) -o /usr/libexec/docker/cli-plugins/docker-compose
sudo chmod +x /usr/libexec/docker/cli-plugins/docker-compose

systemctl enable --now docker

useradd jenkins
usermod -aG docker jenkins

mkdir -p /opt/jenkins/init-scripts
chown -R jenkins:jenkins /opt/jenkins
#${bucket_name} is injected by terraform templatefile
aws s3 cp "s3://${bucket_name}/jenkins/" "/opt/jenkins/init-scripts/" --recursive
mv /opt/jenkins/docker-compose.yml ../docker-compose.yml
chmod -R +x /opt/jenkins/init-scripts/

sudo -u jenkins docker compose up -d

## scuffed script to wait for container config
## until this can be replaced with ansible
FLAG_PATH=/var/jenkins_home/init-scripts-done.flag
CONTAINER_NAME=jenkins
TIMEOUT=120
INTERVAL=2
ELAPSED=0

while ! sudo -u jenkins docker exec "$CONTAINER_NAME" test -f "$FLAG_PATH"; do
    sleep $INTERVAL
    ELAPSED=$((ELAPSED + INTERVAL))
    
    if [ $ELAPSED -ge $TIMEOUT ]; then
        echo "Timeout waiting for init scripts to complete in container $CONTAINER_NAME"
        exit 1
    fi
done

echo "Init scripts completed. Restarting container..."

sudo -u jenkins docker restart jenkins