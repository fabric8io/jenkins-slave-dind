FROM jpetazzo/dind

# Make sure the package repository is up to date.
RUN apt-get update
RUN apt-get -y upgrade

# Install a basic SSH server
RUN apt-get install -y openssh-server
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

# Install JDK 7 (latest edition)
RUN apt-get install -y openjdk-7-jdk

# Add user jenkins to the image
RUN adduser --quiet jenkins
RUN adduser jenkins docker
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

#Add startup script
ADD start-jenkins-slave.sh /usr/bin/start-jenkins-slave.sh

# Standard SSH port
EXPOSE 22

ENV DOCKER_DAEMON_ARGS="--insecure-registry=172.0.0.0/8 --insecure-registry=172.30.0.0/16 "
CMD ["start-jenkins-slave.sh"]
