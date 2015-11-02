FROM adamkdean/baseimage
MAINTAINER Adam K Dean <adamkdean@googlemail.com>

# Install simple dependencies (jdk, git)
RUN apt-get update && \
    apt-get install -q -y openjdk-7-jre-headless && \
    apt-get install -q -y git

# Install latest version of docker
RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -q -y docker-engine

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
