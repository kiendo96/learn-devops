#!/bin/bash

# this script is only tested on ubuntu xenial

# create /var/jenkins_home directory owned by current user
mkdir -p /var/jenkins_home
chown -R 1000:1000 /var/jenkins_home

# run jenkins server in container
docker run -p 8080:8080 -p 50000:50000 -v /var/jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -d --name jenkins-server jenkins/jenkins:2.356

# show endpoint
echo 'Jenkins installed'
echo 'You should now be able to access jenkins at: http://'$(curl -s ifconfig.co)':8080'