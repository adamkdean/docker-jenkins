FROM adamkdean/baseimage
MAINTAINER Adam K Dean <adamkdean@googlemail.com>

# Install simple dependencies (jdk, git)
RUN apt-get update && \
    apt-get install -q -y openjdk-7-jre-headless && \
    apt-get install -q -y git

# Install latest version of docker
RUN apt-get install -q -y apt-transport-https && \
    echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 && \
    apt-get update && \
    apt-get install -q -y lxc-docker

# Clean up after ourselves
RUN apt-get clean

# Download and configure Jenkins
ADD http://mirrors.jenkins-ci.org/war/latest/jenkins.war /opt/jenkins.war
RUN chmod 644 /opt/jenkins.war
ENV JENKINS_HOME /jenkins

# Let's disable StrictHostKeyChecking because it's so frustrating
RUN echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config

EXPOSE 8000

CMD ["java", "-jar", "/opt/jenkins.war", "--httpPort=8000"]
