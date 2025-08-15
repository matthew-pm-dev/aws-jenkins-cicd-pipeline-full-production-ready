FROM jenkins/jenkins:jdk17

USER root

ARG DOCKER_GID

RUN groupadd -f -o -g "$DOCKER_GID" docker \
    && usermod -aG docker jenkins

RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    jenkins-plugin-cli --plugins maven-plugin && \
    rm -rf /var/lib/apt/lists/*

#COPY init-scripts/ /var/jenkins_home/init.groovy.d/

USER jenkins

