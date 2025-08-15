#!/bin/bash
set -euo pipefail

# match container docker GID to host
DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
groupadd -f -o -g "$DOCKER_GID" docker
usermod -aG docker jenkins

# Install build tools if needed (as root)
apt-get update -y

apt-get install -y curl

curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt-get install -y nodejs

jenkins-plugin-cli --plugins maven-plugin

# Jenkins image entrypoint
exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"

