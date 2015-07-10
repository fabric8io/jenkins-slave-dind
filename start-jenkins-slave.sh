#!/bin/bash

echo "export DOCKER_HOST=unix:///var/run/docker.sock" >> /home/jenkins/.profile

#copy ssh keys
mkdir -p /home/jenkins/.ssh
chmod 700 /home/jenkins/.ssh
cp /home/jenkins/ssh-keys/authorized_keys /home/jenkins/.ssh/authorized_keys
chown -R jenkins:jenkins /home/jenkins/.ssh
chmod 600 /home/jenkins/.ssh/authorized_keys
#start docker in docker
nohup wrapdocker &

#Start SSHD
/usr/sbin/sshd -D

# lets wait a little bit for docker
sleep 5

for imageTar in /images/*.tar; do
  echo "Importing docker image ${imageTar}"
  docker load -i ${imageTar}
done
