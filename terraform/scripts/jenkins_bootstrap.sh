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