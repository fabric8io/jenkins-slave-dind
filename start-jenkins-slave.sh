#!/bin/bash

echo "export DOCKER_HOST=unix:///var/run/docker.sock" >> /home/jenkins/.profile
#start docker in docker
nohup wrapdocker &

#Start SSHD
/usr/sbin/sshd -D

