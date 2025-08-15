#!/bin/bash
# Fix Docker group inside container to match host socket
DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
groupadd -f -o -g "$DOCKER_GID" docker
usermod -aG docker jenkins
