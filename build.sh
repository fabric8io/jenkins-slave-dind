#!/bin/bash

echo "Pulling the images"
for img in maven; do
  docker pull ${img}
  docker save ${img} > images/${img}.tar
done

docker build -t fabric8/jenkins-slave-dind .
  
