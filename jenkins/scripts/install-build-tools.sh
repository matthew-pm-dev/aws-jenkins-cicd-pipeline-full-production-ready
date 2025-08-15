#!/bin/bash
apt-get update -y

apt-get install -y curl

curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt-get install -y nodejs

jenkins-plugin-cli --plugins maven-plugin