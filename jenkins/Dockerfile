FROM jenkins/jenkins:jdk17

USER root

ARG DOCKER_GID
RUN groupadd -f -o -g "$DOCKER_GID" docker \
    && usermod -aG docker jenkins

RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

#COPY init-scripts/ /usr/share/jenkins/ref/init.groovy.d/

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

COPY casc-config/jenkins.yml /usr/share/jenkins/ref/casc-config/jenkins.yml

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false -Dcasc.jenkins.config=/usr/share/jenkins/ref/casc-config"

USER jenkins

