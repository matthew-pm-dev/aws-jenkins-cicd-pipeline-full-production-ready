FROM jenkins/jenkins:latest

VOLUME /var/jenkins_home

EXPOSE 8080 50000

USER root

RUN apt-get update && apt-get install -y \
    maven \
    npm \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/jenkins_home

USER jenkins